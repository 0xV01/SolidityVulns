# Reentrancy

## Description:

This Vulnerability is exploiting external calls which can be Hijacked by an Attacker. The Attacker can then forces the contract to execute further code through his (Attackers Contract) fallback function or call back into the Vulnerable contract.

## The Vulnerability:

This kind of Attack can accure when an Vulnerable Contract is sending Ether to an unknown address through a call. The Attacker at the unknown address has a fallback function with a maliciouse code. This code most of the time calls back into the Vulnerable contract and this is where unexpected operations can happen that where not intended by the developer like draining all the funds out of the Contract.

## Preventive Techniques:

All logic that changes state variables should happen before the call.
A Mutex can also be used to lock the function before making the call for example OpenZeppelins ReentranceGuard.sol

## Code

- [VulnContract.sol](VulnContract.sol) contains the Vulnerable Code.
- [Attacker.sol](Attacker.sol) contains the exploiter.
- [FixedContract.sol](FixedContract.sol) contains the fixed version of the VulnContract.sol
