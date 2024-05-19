// SPDX-License-Identifier: MIT


pragma solidity ^0.8.24;

import "./BondToken.sol";
import "forge-std/console.sol";

contract lending
{
  
    struct Lender
    {
    uint256  amount;
    }
     
 
    struct Borrower
     {
     uint256 amount;
     uint256 collateral;
     }
     mapping (address=>Lender) public lenders;
     mapping (address=>Borrower) public borrowers;
     address[] public listLenders;
     address[] public listBorrowers ;
     IERC20 public dai;
     BondToken  public bondToken;
    uint256 public maxLTV=80;
    address public owner;
 constructor()
 {
    owner=msg.sender;
   dai=IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
   bondToken=new BondToken();
}
modifier onlyOwner()
{
    require (owner==msg.sender,"not permission");
    _;
}
function getPrecent(uint256 value) public returns(uint256)
{
    return (value*maxLTV)/100;
}

function deposite(uint256 amountofdai) public
{
    require(amountofdai>0,"invalid ammount");
    dai.transferFrom(msg.sender,address(this),amountofdai);
    bondToken.mint(msg.sender,amountofdai);
    if (lenders[msg.sender].amount==0) 
      listLenders.push(msg.sender);
    lenders[msg.sender].amount+=amountofdai;
       
}
function withdraw(uint256 amountofdai) public
{
    require(amountofdai<=lenders[msg.sender].amount,"Not enough DAI to withdraw");

    dai.transferFrom(address(this),msg.sender,amountofdai);
    bondToken.burn(msg.sender,amountofdai);
    lenders[msg.sender].amount-=amountofdai;

}
function addCollateral() public payable
{
    if (borrowers[msg.sender].amount==0)
     listBorrowers.push(msg.sender);

  borrowers[msg.sender].collateral+=msg.value;

}

function removeCollateral(uint256 amount) public
{
 require(getPrecent(borrowers[msg.sender].collateral-amount)>=borrowers[msg.sender].amount,"Not enough collateral to remove them");
 borrowers[msg.sender].collateral-=amount;
}
function getBorrow (uint256 amountofborrow) payable public
    {
        if (msg.value>0) 
          addCollateral();

//convert ammount to value of dai
    borrowers[msg.sender].amount+=amountofborrow;
    require(getPrecent(borrowers[msg.sender].collateral)>=borrowers[msg.sender].amount,"Not enouge collaterals to get borrow")  ; 
    dai.transferFrom(address(this),msg.sender,amountofborrow);
    }

function removeBorrow(uint256 amountofborrow) public
{
require(borrowers[msg.sender].amount<=amountofborrow,"you are return amount of borrow that greater from you take");
dai.transferFrom(msg.sender,address(this),amountofborrow);
borrowers[msg.sender].amount-=amountofborrow;
}

function checkLiquidation() public onlyOwner{}
function  harvestRewards() public onlyOwner{}
function convertETH () public onlyOwner{}
} 