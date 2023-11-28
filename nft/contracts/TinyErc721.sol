// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import 'tiny-erc721/contracts/TinyERC721.sol';

contract TinyErc721 is TinyERC721 {
  // third constructor argument is maximum batch size, 0 for no limit
  constructor(uint256 _maxBatchSize) TinyERC721('Authorization', 'AUTHNFT', _maxBatchSize) {}

  // second argument for _mint is quantity instead of token id
  function mint(address to, uint256 quantity) external payable {
    _mint(to, quantity);
  }
}
