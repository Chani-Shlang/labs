// SPDX-License-Identifier:MIT

pragma solidity ^0.8.24;

import {AuctionContract} from  "./auctionContract.sol"; 
import{Test,console} from "forge-std/Test.sol";
import{MyERC721} from "./MyERC721.sol";

contract TestAuctionContract is Test{
    AuctionContract public auctionContract;
    MyERC721 tokenNFT;

receive() external payable{}

function setUp() public{
    tokenNFT=new MyERC721();
   // tokenNFT=IERC20(address);
    auctionContract=new AuctionContract(address(tokenNFT));

}
function testcreateAuction() public payable
{
    uint256 tokenId=1;
    uint256 amount =100 ether;
    uint256 auctionendDate=block.timestamp+3600;
    tokenNFT.mint(address(this),tokenId);
    console.log(address(this));
    console.log(tokenNFT.ownerOf(tokenId))    ;
    tokenNFT.approve(address(auctionContract),tokenId);
    auctionContract.createAuction{value:amount}(auctionendDate,tokenId);
    console.log(auctionContract.getAuctionList(0).bid);
    vm.startPrank(address(4));
    vm.deal(address(4),200 ether);
    auctionContract.createBid{value:150 ether}(0);
    console.log(auctionContract.getAuctionList(0).bid);
    console.log(address(auctionContract));  
    console.log(tokenNFT.ownerOf(1));  
    vm.warp(4000);
    auctionContract.getNftForWinner(0);
    console.log(tokenNFT.ownerOf(1));

    
}

}