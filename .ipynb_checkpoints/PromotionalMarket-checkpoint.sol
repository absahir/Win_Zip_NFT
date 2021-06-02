pragma solidity ^0.5.5;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC721/ERC721Full.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/ownership/Ownable.sol";
import "./PromotionalAuction.sol";

contract PromotionalMarket is ERC721Full, Ownable {

    constructor() ERC721Full ("PROMOAD", "AD") public {}
    
    using Counters for Counters.Counter;

    Counters.Counter token_ids;
    
    address payable public beneficiary;
    
    mapping(uint => PromotionalAuction) public auctions;
    
     modifier AdRegistered(uint token_id) {
        require(_exists(token_id), "AD not registered!");
        _;
    }
    
     function createAuction(uint token_id) public onlyOwner {
        auctions[token_id] = new PromotionalAuction(beneficiary);
    }
    
     function registerAD(string memory uri) public payable onlyOwner {
        token_ids.increment();
        uint token_id = token_ids.current();
        _mint(beneficiary, token_id);
        _setTokenURI(token_id, uri);
        createAuction(token_id);
    }
    
    function endAuction(uint token_id) public onlyOwner AdRegistered(token_id) {
        PromotionalAuction auction = auctions[token_id];
        auction.auctionEnd();
        safeTransferFrom(owner(), auction.highestBidder(), token_id);
    }
    
     function auctionEnded(uint token_id) public view returns(bool) {
        PromotionalAuction auction = auctions[token_id];
        return auctionEnded();
    }
    
    function highestBid(uint token_id) public view AdRegistered(token_id) returns(uint) {
        PromotionalAuction auction = auctions[token_id];
        return highestBid();
    }
    
    function pendingReturn(uint token_id, address sender) public view AdRegistered(token_id) returns(uint) {
        PromotionalAuction auction = auctions[token_id];
        return pendingReturn(sender);
    }
    
    function bid(uint token_id) public payable AdRegistered(token_id) {
        PromotionalAuction auction = auctions[token_id];
        bid.value(msg.value)(msg.sender);
    }

}
