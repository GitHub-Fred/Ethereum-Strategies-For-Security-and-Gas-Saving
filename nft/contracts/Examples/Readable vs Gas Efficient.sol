// SPDX-License-Identifier: MIT
/*
pragma solidity ^0.8.19;

import "../standards/ERC721A.sol";

contract ReadableERC721A is ERC721A {
    uint256 public constant MAX_TRANSACTION_AMOUNT = 10;

    function mint(uint256 quantity) external payable {
        require(quantity <= MAX_TRANSACTION_AMOUNT, "Max amount exceeded");
        _mint(msg.sender, quantity);
    }
}

contract GasEfficientERC721A is ERC721A {
    uint256 public constant MAX_TRANSACTION_AMOUNT = 11;

    function mint(uint256 quantity) external payable {
        require(quantity < MAX_TRANSACTION_AMOUNT, "Max amount exceeded");
        _mint(msg.sender, quantity);
    }
}
*/