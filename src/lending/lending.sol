// SPDX-License-Identifier: MIT


pragma solidity ^0.8.24;

import "./BondToken.sol";
import "forge-std/console.sol";
import "../../lib/foundry-chainlink-toolkit/src/interfaces/feeds/AggregatorV2V3Interface.sol";
contract Lending
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
    uint256 public maxLQ=90;
    address public owner;
    AggregatorV3Interface public priceFeed;
    uint256 public fee;
 
 constructor(address _dai)
 {
   owner=msg.sender;
   //dai=IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
   dai=IERC20(_dai);
   bondToken=new BondToken();
   priceFeed=AggregatorV3Interface(0x779877A7B0D9E8603169DdbD7836e478b4624789);
}
modifier onlyOwner()
{
    require (owner==msg.sender,"not permission");
    _;
}
function getPrecent(uint256 value,uint256 precent) public returns(uint256)
{
    return (value*precent)/100;
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
 require(getPrecent(borrowers[msg.sender].collateral-amount,maxLTV)>=borrowers[msg.sender].amount,"Not enough collateral to remove them");
 borrowers[msg.sender].collateral-=amount;
 payable(msg.sender).transfer(amount);
}

function getEthInDai() public returns(uint256)
{

    return 3000;
}

function getBorrow (uint256 amountofborrow) payable public
    {
        if (msg.value>0) 
          addCollateral();

   
    borrowers[msg.sender].amount+=amountofborrow;

    require(getPrecent(borrowers[msg.sender].collateral,maxLTV)*getEthInDai()>=borrowers[msg.sender].amount,"Not enouge collaterals to get borrow")  ; 
    //uint amountNeto=amountofborrow-amountofborrow*fee;
    dai.transferFrom(address(this),msg.sender,amountofborrow);
    
    
    }

function removeBorrow(uint256 amountofborrow) public
{
  
  dai.transferFrom(msg.sender,address(this),amountofborrow+fee);
  borrowers[msg.sender].amount-=amountofborrow;

  for (uint256 i=0;i<listLenders.length;i++)
      dai.transferFrom(address(this),listLenders[i],fee*(lenders[listLenders[i]].amount/dai.balanceOf(address(this))));
}

function checkLiquidation() public onlyOwner{
    for(uint256 i=0;i<listBorrowers.length;i++)
    {
      if(((borrowers[listBorrowers[i]].amount*getEthInDai())/borrowers[listBorrowers[i]].collateral)*100>maxLQ)
       
       
       { uint256 collateralDiff=borrowers[listBorrowers[i]].collateral-(borrowers[listBorrowers[i]].collateral)*maxLQ;
  
         harvestRewards(collateralDiff);         
         borrowers[listBorrowers[i]].collateral=0;
       } 
    }
}
function  harvestRewards(uint256 amount) public onlyOwner{
    payable(owner).transfer(amount);
}
function convertETH () public onlyOwner{}
} 