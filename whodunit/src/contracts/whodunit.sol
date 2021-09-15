// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0;

contract WhoDunIt {

    string name;

    constructor() {
        name = "whodunit";
    }

    function getName() public view returns (string memory) {
        return name;
    }
    
    uint public contestCount = 0;
    uint public bidCount = 0;

    // List of all product
    mapping(uint => Contest) public Contests;
    Contest[] public ContestList;
    
    // Get bids for a user
    mapping(address => Bid[]) public UserBids;
    mapping(address => PlacedBid[]) public CreatorBids;
    
    struct Contest {
        uint contestId;
        string imei;
        string name;
        string description;
        uint value;
        uint entry;
        uint256 deadline;
        address payable creator;
    }
    
    struct Bid {
        uint bidId;
        uint contestId;
        string status;
        address bidder;
        address creator;
        uint value;
    }
    
    struct PlacedBid {
        uint bidId;
        uint contestId;
        string status;
        address bidder;
        address creator;
        uint value;
    }
    
    function createContest(string memory _name, string memory _imei, string memory _description, uint _price, uint _entry, uint256 _deadline) public {
        Contest memory contest = Contest(contestCount, _imei, _name, _description, _price, _entry, _deadline, payable(msg.sender)); // Create new instance of struct
        Contests[contestCount].contestId = contestCount;
        Contests[contestCount].imei = _imei;
        Contests[contestCount].name = _name;
        Contests[contestCount].description = _description;
        Contests[contestCount].value = _price;
        Contests[contestCount].entry = _entry;
        Contests[contestCount].deadline = _deadline;
        Contests[contestCount].creator = payable(msg.sender);
        ContestList.push(contest);
        
        contestCount = contestCount + 1; // Increment contest count for subsequent products
    }
    
    function createBid(uint _id) public payable {
        require(msg.value == Contests[_id].entry, "Incorrect value of funds to enter contest"); // Check if user is eligible to bid and has paid the entry
        
        Bid memory bid = Bid(bidCount, _id, "Bid Placed", msg.sender, Contests[_id].creator, Contests[_id].value); // Create new instance of struct
        UserBids[msg.sender].push(bid); // Add bid to list of users' bids
        
        PlacedBid memory placedBid = PlacedBid(bidCount, _id, "Bid Placed", msg.sender, Contests[_id].creator, Contests[_id].value); // Create new instance of struct
        CreatorBids[Contests[_id].creator].push(placedBid); // Add placed bid to list of creators' bids
        
        Contests[_id].creator.transfer(msg.value); // Transfer entry to creator
        
        bidCount = bidCount + 1; // Increment bid count for subsequent orders
    }
    
}