pragma solidity  ^ 0.5.5;

contract PromotionalAuction{
// Parameters of the PromotionalAuction
    address payable public beneficiary;
    uint public auctionEndTime;
    address deployer;
    
// Current state of the auctionEndTime
    address public highestBidder;
    uint public highestBid;
    
    mapping(address => uint) public pendingReturns;
    
    bool ended = false;
    
    event HighestBidIncrease(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);
    
    constructor(uint _biddingTime, address payable _beneficiary) public {
        deployer = msg.sender;
        beneficiary = _beneficiary;
        auctionEndTime = block.timestamp + _biddingTime;
    }
    
    function bid() public payable{
        if (block.timestamp > auctionEndTime){
        revert("The auction has already ended");
        }
        
        if (msg.value <= highestBid){
        revert("There is already a higher or equal bid");
        }
        
        if (highestBid != 0){
        pendingReturns[highestBidder] += highestBid;
        }
        
        highestBidder = msg.sender;
        highestBid = msg.value;
        emit HighestBidIncrease(msg.sender, msg.value);
    
    }
    
    function pendingReturn(address sender) public view returns (uint) {
        return pendingReturns[sender];
    }
    
    function withdraw() public returns (bool) {
        uint amount = pendingReturns[msg.sender];
        if(amount > 0){
        pendingReturns[msg.sender] = 0;
        }
        if(!(msg.sender).send(amount)){
            pendingReturns[msg.sender] = amount;
            return false;
            
        }
        return true;
    }
    
    function auctionEnd() public {
        if(block.timestamp < auctionEndTime){
            revert("The auction has not ended yet");
        }
        if(ended){
            revert("The function auctionEnded has already been called");
        }
        
        ended = true;
        emit AuctionEnded(highestBidder, highestBid);
        
        beneficiary.transfer(highestBid);
    }
    
}