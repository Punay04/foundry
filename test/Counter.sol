// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/Counter.sol";

contract TestCounter is Test {
    Counter c;

    function setUp() public {
        c = new Counter(3);
    }

    function testIncrement() public {
        c.increment();
        assertEq(c.getNum(), uint256(101) , "ok");
    }

    function testDecrement() public {
        c.decrement();
        assertEq(c.getNum(), uint256(99) , "ok");
    }

 
}
