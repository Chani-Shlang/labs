//SPDX-License-Identifier:MIT
pragma solidity ^0.8.24;

contract Ifelse 
{
function foo(uint256 _num) public pure returns (uint256)
{
    if (_num<10)
  
        {
        return 1;
        }
        else if (_num<20)
        {
            return 2;
        }
        else 
        {
        return 3;
        }
  
}

function ternary(uint256 _num) public pure  returns (uint256)

{
    return _num<10 ?1 : 3;
}

}