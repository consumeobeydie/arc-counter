// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Counter {
    address public owner;
    int256 public count;
    uint256 public incrementCount;
    uint256 public decrementCount;

    event Incremented(address indexed by, int256 newValue);
    event Decremented(address indexed by, int256 newValue);
    event Reset(address indexed by);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can reset");
        _;
    }

    constructor() {
        owner = msg.sender;
        count = 0;
        incrementCount = 0;
        decrementCount = 0;
    }

    function increment() public {
        count++;
        incrementCount++;
        emit Incremented(msg.sender, count);
    }

    function decrement() public {
        count--;
        decrementCount++;
        emit Decremented(msg.sender, count);
    }

    function reset() public onlyOwner {
        count = 0;
        incrementCount = 0;
        decrementCount = 0;
        emit Reset(msg.sender);
    }

    function getCount() public view returns (int256) {
        return count;
    }

    function getStats() public view returns (int256, uint256, uint256) {
        return (count, incrementCount, decrementCount);
    }
}
