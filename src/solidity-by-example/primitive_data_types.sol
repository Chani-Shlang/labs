//SPDX-License-Identifier:MIT
pragma solidity ^0.8.24;

contract Primitives
{
    uint256 public u8=1;
    uint256  public u256=456;
    uint256 public u=123;

    int256 public i8=-1;
    int256 public i256=456;
    int256 public i=-123;

    int256 minInt=type(int256).min;
    int256 maxInt=type(int256).max;
    address  public add=0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;


    //defualt
    address public addDefualt;//0x00000000000000000
    uint256 public uintDefualt;//0
    int256 public intDefualt;//0
    bool   public boolDefualt;//false

}