//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract getCode {

    function getPassword(bytes32 passwordStorage) public pure returns (bytes16) {
        return bytes16(passwordStorage);
    }
}