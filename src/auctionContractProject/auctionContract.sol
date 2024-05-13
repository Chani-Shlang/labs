// SPDX-License-Identifier:MIT

pragma solidity ^0.8.24;


import "forge-std/interfaces/IERC721.sol";
import "forge-std/console.sol";

contract AuctionContract
{   
    struct Auction{
    address seller;
    bool  auctionStart;
    uint256  auctionendDate; 
    uint256 tokenId;
    uint256 bid;
    address addressOfHigeBidder;

    }
IERC721  tokenNFT;
uint256 counter;
mapping(uint256 =>Auction) public AuctionList;//for each Auction return ID
 
 modifier OnlySeller(uint256 AuctionId)
 {
    require(msg.sender==AuctionList[AuctionId].seller,"You do not have permission to update");
    _;
 }

constructor(address _tokenNFT)
 {
   tokenNFT=IERC721(_tokenNFT);
}

 function setendDate(uint256 auctionId,uint256 auctionendDate) public OnlySeller(auctionId) {
    require (AuctionList[auctionId].auctionendDate<auctionendDate);
    AuctionList[auctionId].auctionendDate=auctionendDate;
 }

 function getAuctionList(uint256 actionId) public view returns(Auction memory) {
  return AuctionList[actionId];
 }
 
 
 function createAuction(uint256 endDate,uint256 tokenId )  public payable returns (uint256)
 {
    console.log("create");
    AuctionList[counter].seller=msg.sender;
    AuctionList[counter].tokenId=tokenId;
    AuctionList[counter].auctionStart=true;
    console.log(endDate);
    AuctionList[counter].auctionendDate=endDate;
    console.log('after create');
    
    tokenNFT.transferFrom(msg.sender, address(this), tokenId);

   createBid(counter);
   counter++;
   return counter-1;
 }

function createBid(uint256 auctionId )  public payable
{
console.log(msg.sender);
require(AuctionList[auctionId].auctionStart,"Auction does not started");
require(block.timestamp<AuctionList[auctionId].auctionendDate,"Invalid date");
require (msg.value>AuctionList[auctionId].bid,"Suggation is less");
 
payable(AuctionList[auctionId].addressOfHigeBidder).transfer(AuctionList[auctionId].bid);
AuctionList[auctionId].bid= msg.value;
AuctionList[auctionId].addressOfHigeBidder=msg.sender;

}



function getNftForWinner(uint256 auctionId) public
{
    require(AuctionList[auctionId].auctionendDate<block.timestamp,"The sale is not over yet");
    tokenNFT.transferFrom(address(this),AuctionList[auctionId].addressOfHigeBidder, AuctionList[auctionId].tokenId);
    payable(AuctionList[auctionId].addressOfHigeBidder).transfer(AuctionList[auctionId].bid);

}

}