//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract ForceSender {
    function collect() public payable returns (uint256) {
        return address(this).balance;
    }

    function destroyContract() public payable {
        address payable contractAddress = payable(
            address(0x82d3B630125A4338E60f9EbD8241EC7eb1fda1F3)
        );
        selfdestruct(contractAddress);
    }
}
