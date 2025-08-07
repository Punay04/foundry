// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {console} from "../lib/forge-std/src/console.sol";

contract MyToken is ERC20 {
    address owner;

    constructor(uint256 _initialSupply) ERC20("MyToken", "MTK") {
        owner = msg.sender;
        _mint(msg.sender, _initialSupply);
    }

    function mint(address _to, uint256 _amount) public {
        console.log("Minting");
        require(msg.sender == owner, "Owner only");
        _mint(_to, _amount);
        console.log("Minted");
    }

    // function transfer(address _to, uint256 _amount) public {
      
    // }
}
