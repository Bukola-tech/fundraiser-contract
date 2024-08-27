// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Fundraiser {
    // Structure of a campaign
    struct Campaign {
        string title;
        string description;
        address payable benefactor;
        uint goal;
        uint deadline;
        uint amountRaised;
        bool ended;
    }
//hi
    // State variables
    Campaign[] public campaigns;
    address public owner;
    mapping(uint => mapping(address => bool)) public hasDonated; // Tracks if an address has donated to a campaign

    // Events
    event CampaignCreated(uint campaignId, string title, address benefactor);
    event DonationReceived(uint campaignId, address donor, uint amount);
    event CampaignEnded(uint campaignId, uint amountRaised, bool goalReached);
    event FundsWithdrawn(address owner, uint amount);

    // Modifier to restrict access to the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner.");
        _;
    }

    // Modifier to check if the campaign is still active
    modifier isActive(uint _campaignId) {
        require(block.timestamp < campaigns[_campaignId].deadline, "Campaign has ended.");
        _;
    }

    // Constructor to set the owner of the contract
    constructor() {
        owner = msg.sender;
    }

    // Create a new campaign
    function createCampaign(
        string memory _title,
        string memory _description,
        address payable _benefactor,
        uint _goal,
        uint _duration
    ) public {
        require(_goal > 0, "Goal should be greater than zero.");

        uint deadline = block.timestamp + _duration;

        campaigns.push(Campaign({
            title: _title,
            description: _description,
            benefactor: _benefactor,
            goal: _goal,
            deadline: deadline,
            amountRaised: 0,
            ended: false
        }));

        emit CampaignCreated(campaigns.length - 1, _title, _benefactor);
    }

    // Donate to a campaign
    function donate(uint _campaignId) public payable isActive(_campaignId) {
        Campaign storage campaign = campaigns[_campaignId];
        require(msg.value > 0, "Donation must be greater than zero.");
        require(!hasDonated[_campaignId][msg.sender], "You have already donated to this campaign.");

        campaign.amountRaised += msg.value;
        hasDonated[_campaignId][msg.sender] = true; // Mark as donated

        emit DonationReceived(_campaignId, msg.sender, msg.value);
    }

    // End a campaign and transfer funds to the benefactor
    function endCampaign(uint _campaignId) public {
        Campaign storage campaign = campaigns[_campaignId];

        require(block.timestamp >= campaign.deadline, "Campaign is still active.");
        require(!campaign.ended, "Campaign has already ended.");

        campaign.ended = true; // Mark the campaign as ended to prevent re-entrancy

        uint amount = campaign.amountRaised;
        campaign.amountRaised = 0; // Reset the amount raised

        (bool sent, ) = campaign.benefactor.call{value: amount}("");
        require(sent, "Failed to send funds to the benefactor.");

        emit CampaignEnded(_campaignId, amount, amount >= campaign.goal);
    }

    // Withdraw leftover funds from the contract (only by the owner)
    function withdrawLeftoverFunds() public onlyOwner {
        uint balance = address(this).balance;
        require(balance > 0, "No funds to withdraw.");

        (bool sent, ) = owner.call{value: balance}("");
        require(sent, "Failed to withdraw funds.");

        emit FundsWithdrawn(owner, balance);
    }
}
