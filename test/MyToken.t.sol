// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/MyToken.sol";

contract TestMyToken is Test {
    MyToken c;

    function setUp() public {
        c = new MyToken(0);
    }

    function testMint() public {
        c.mint(address(this), uint256(100));
        assertEq(c.balanceOf(address(this)), uint256(100), "ok");
    }

    function testTransfer() public {
        c.mint(address(this), 100);
        c.transfer(0xF973D0CCeCcef2532c53081079FDe3F7D29279C0, 50);

        assertEq(
            c.balanceOf(0xF973D0CCeCcef2532c53081079FDe3F7D29279C0),
            50,
            "ok"
        );
        assertEq(c.balanceOf(address(this)), 50);

        vm.prank(0xF973D0CCeCcef2532c53081079FDe3F7D29279C0);
        c.transfer(address(this), 50);
    }

    function testApprovals() public {
        c.mint(address(this), 100);

        c.approve(0xF973D0CCeCcef2532c53081079FDe3F7D29279C0, 50);

        assertEq(
            c.allowance(
                address(this),
                0xF973D0CCeCcef2532c53081079FDe3F7D29279C0
            ),
            50,
            "ok"
        );

        vm.prank(0xF973D0CCeCcef2532c53081079FDe3F7D29279C0);
        c.transferFrom(
            address(this),
            0xF973D0CCeCcef2532c53081079FDe3F7D29279C0,
            10
        );

        assertEq(c.balanceOf(address(this)), 90, "ok");
        assertEq(
            c.balanceOf(0xF973D0CCeCcef2532c53081079FDe3F7D29279C0),
            10,
            "ok"
        );
        assertEq(
            c.allowance(
                address(this),
                0xF973D0CCeCcef2532c53081079FDe3F7D29279C0
            ),
            40,
            "ok"
        );
    }

    function test_RevertWhen_TransferFromExceedsAllowance() public {
        c.mint(address(this), 20);
        c.approve(0xF973D0CCeCcef2532c53081079FDe3F7D29279C0, 10);

        vm.prank(0xF973D0CCeCcef2532c53081079FDe3F7D29279C0);
        vm.expectRevert();
        c.transferFrom(
            address(this),
            0xF973D0CCeCcef2532c53081079FDe3F7D29279C0,
            100
        );
    }

    function test_RevertWhen_TransferExceedsBalance() public {
        c.mint(address(this), 20);
        vm.expectRevert();
        c.transfer(0xF973D0CCeCcef2532c53081079FDe3F7D29279C0, 100);
    }
}
