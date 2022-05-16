//SPDX-License-Identifier: MIT

pragma solidity 0.8.13;

contract VulnContract {
    mapping(address => uint256) balances;

    function deposite() external payable {
        require(msg.value > 0, "Not enought send");
        balances[msg.sender] += msg.value;
    }

    //This is the Vulnerable function.
    function withdraw(uint256 amount) external {
        require(
            amount <= balances[msg.sender],
            "Not enought funds to withdraw"
        );

        /*
         * Here we are sending the ether before updating the balance in the mapping.
         * This opens a door to an attacker to reenter the function and drain the entire funds.
         */
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Failed to withdraw");
        balances[msg.sender] -= amount;
    }
}
