// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract PenglingErc1155 is ERC1155 {
    constructor(uint256 _maxBatchSize) ERC1155("ipfs://QmVhFBg3CU52CnhEMt1N84Ly8KKuGyUFVLivk4x4ni94sF") {}

    function publicMint(address account, uint256 amount) public {
        _mint(account, 1, amount, "");
    }

    function mint(
        address account,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) internal {
        _mint(account, id, amount, data);
    }

    function mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public {
        _mintBatch(to, ids, amounts, data);
    }
}
