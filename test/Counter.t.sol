// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "forge-std/Test.sol";
import "../src/Counter.sol";

contract CounterTest is Test {
    Counter counter;
    address owner;
    address user;

    function setUp() public {
        owner = address(this);
        user = address(0x1234);
        counter = new Counter();
    }

    function testInitialCount() public view {
        assertEq(counter.getCount(), 0);
    }

    function testIncrement() public {
        counter.increment();
        assertEq(counter.getCount(), 1);
    }

    function testDecrement() public {
        counter.decrement();
        assertEq(counter.getCount(), -1);
    }

    function testMultipleIncrements() public {
        counter.increment();
        counter.increment();
        counter.increment();
        assertEq(counter.getCount(), 3);
    }

    function testIncrementAndDecrement() public {
        counter.increment();
        counter.increment();
        counter.decrement();
        assertEq(counter.getCount(), 1);
    }

    function testReset() public {
        counter.increment();
        counter.increment();
        counter.reset();
        assertEq(counter.getCount(), 0);
    }

    function testOnlyOwnerCanReset() public {
        counter.increment();
        vm.prank(user);
        vm.expectRevert("Only owner can reset");
        counter.reset();
    }

    function testGetStats() public {
        counter.increment();
        counter.increment();
        counter.decrement();
        (int256 count, uint256 inc, uint256 dec) = counter.getStats();
        assertEq(count, 1);
        assertEq(inc, 2);
        assertEq(dec, 1);
    }

    function testIncrementedEvent() public {
        vm.expectEmit(true, true, true, true);
        emit Counter.Incremented(address(this), 1);
        counter.increment();
    }

    function testDecrementedEvent() public {
        vm.expectEmit(true, true, true, true);
        emit Counter.Decremented(address(this), -1);
        counter.decrement();
    }
}
