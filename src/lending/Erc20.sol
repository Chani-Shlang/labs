// SPDX-License-Identifier:MIT

pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MYERC20 is ERC20{
    

    constructor() ERC20("ERC20","ERC")
    {

    }

    function mint (address to,uint256 tokenId) external
    {
        _mint(to,tokenId);
    }

    function   burn(address to, uint256 value) external 
    {
         _burn(to, value);
    }
 }