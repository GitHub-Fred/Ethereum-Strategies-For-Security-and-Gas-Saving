// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./standards/ERC721A2PM.sol";

contract Erc721Azuki is ERC721A2PM {
    constructor(uint256 _maxBatchSize) ERC721A2PM("Gas Checker", "GasChecker", _maxBatchSize) {}

    function mint(address to, uint256 quantity) public {
        _safeMint(to, quantity);
    }
}
