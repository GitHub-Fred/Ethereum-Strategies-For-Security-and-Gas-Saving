// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyErc1155 is ERC1155, Ownable {
    uint256 private immutable maxBatchSize;

    constructor(uint256 _maxBatchSize) ERC1155("") {
        maxBatchSize = _maxBatchSize;
    }

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function publicMint(address account, uint256 amount) external {
        _mint(account, 2, amount, "");
    }

    function mint(
        address account,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public {
        require(amount <= maxBatchSize, "ERC1155: quantity to mint too high");
        _mint(account, id, amount, data);
    }

    function mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public onlyOwner {
        _mintBatch(to, ids, amounts, data);
    }
}
