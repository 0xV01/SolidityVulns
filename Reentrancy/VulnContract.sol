//SPDX-License-Identifier: MIT

pragma solidity 0.8.13;

contract VulnContract {
    mapping(address => uint256) balances;

    function deposite() external payable {
        require(msg.value > 0, "Not enought send");
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent, "Failed to withdraw");
        balances[msg.sender] = 0;
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
