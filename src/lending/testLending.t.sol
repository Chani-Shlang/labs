// SPDX-License-Identifier:MIT

pragma solidity ^0.8.24;

import {Lending} from  "./lending.sol"; 
import{Test,console} from "forge-std/Test.sol";
import{BondToken} from "./BondToken.sol";
import{MYERC20} from "./Erc20.sol";




contract TestLending is Test
{

Lending  public lending;
MYERC20 public dai;
function setUp() public
{
 dai=new MYERC20();
 console.log("begin");
 lending=new Lending(address(dai));
 
}    

function testLending() public
{   
    dai.mint(address(this),100);
    console.log("begin");
    console.log(dai.balanceOf(address(this)));
    vm.deal(address(this),500);
    dai.approve(address(lending),100);
    lending.deposite(100);
    console.log(dai.balanceOf(address(lending)));
   
}
}