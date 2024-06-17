//SPDX-Licens-Identifier:MIT;
pragma solidity ^0.8.24;

contract Gas{
    uint256 public num=0;
    function forever() public 
    {
        while(true)
        {
         num+=1;
        }
    }
}