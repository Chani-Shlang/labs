// SPDX-License-Identifier:MIT

pragma solidity ^0.8.24;

import {Auction} from  "./auction.sol"; 
import{Test,console} from "forge-std/Test.sol";
import{MyERC721} from "./MyERC721.sol";

contract TestAuction is Test{
    Auction public auction;
    MyERC721 tokenNFT;

receive() external payable{}

function setUp() public{
    tokenNFT=new MyERC721();
    auction=new Auction(address(tokenNFT));

}
function testcreateAuction() public payable
{
    uint256 tokenId=1;
    uint256 amount =100 ether;
    uint256 auctionendDate=block.timestamp+3600;
    tokenNFT.mint(address(this),tokenId);
    console.log(address(this));
    console.log(tokenNFT.ownerOf(tokenId))    ;
    tokenNFT.approve(address(auction),tokenId);
    auction.createAuction{value:amount}(auctionendDate,tokenId);
    console.log(auction.getAuctionList(0).bid);
    vm.startPrank(address(4));
    vm.deal(address(4),200 ether);
    auction.createBid{value:150 ether}(0);
    console.log(auction.getAuctionList(0).bid);
    console.log(address(auction));  
    console.log(tokenNFT.ownerOf(1));  
    vm.warp(4000);
    auction.getNftForWinner(0);
    console.log(tokenNFT.ownerOf(1));

    
}

}