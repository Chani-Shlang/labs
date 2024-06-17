//SPDX-License-Identifier:MIT
pragma solidity ^0.8.24;

contract Immutable{

    address public immutable MYaddress;
    uint256 public immutable MYuint;

    constructor  (uint256 _MYuint)
    {
        MYaddress=msg.sender;
        MYuint=_MYuint;
    }

}