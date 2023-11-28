// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "erc721a/contracts/ERC721A.sol";

contract PenglingERC721A is ERC721A {
    uint256 public constant MAX_TRANSACTION_AMOUNT = 10;
    string public constant baseURIString =
        "ipfs://QmVhFBg3CU52CnhEMt1N84Ly8KKuGyUFVLivk4x4ni94sF";

    constructor() ERC721A("Pengling", "PenglingAzuki") {}

    function _baseURI() internal pure override returns (string memory) {
        return baseURIString;
    }

    function mint(uint256 quantity) external payable {
        if(quantity > MAX_TRANSACTION_AMOUNT) revert("Max amount exceeded");
        _mint(msg.sender, quantity);
    }
}
