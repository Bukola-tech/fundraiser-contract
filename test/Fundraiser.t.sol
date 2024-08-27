// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "forge-std/Test.sol";
// import "../src/Fundraiser.sol";

// contract FundraiserTest is Test {
//     Fundraiser fundraiser;

//     function setUp() public {
//         fundraiser = new Fundraiser();
//     }

//     function testCreateCampaign() public {
//         fundraiser.createCampaign("Build a School", "A campaign to build a school.", payable(address(this)), 1 ether, 1 days);
//         (string memory title, string memory description, address benefactor, uint goal, uint deadline, uint amountRaised, bool ended) = fundraiser.campaigns(0);
//         assertEq(title, "Build a School");
//         assertEq(benefactor, address(this));
//         assertEq(goal, 1 ether);
//         assertFalse(ended);
//     }

//     function testDonate() public {
//         fundraiser.createCampaign("Build a School", "A campaign to build a school.", payable(address(this)), 1 ether, 1 days);
//         vm.deal(address(1), 1 ether);
//         vm.prank(address(1));
//         fundraiser.donate{value: 0.5 ether}(0);

//         (, , , , , uint amountRaised, ) = fundraiser.campaigns(0);
//         assertEq(amountRaised, 0.5 ether);
//     }

//     function testEndCampaign() public {
//         fundraiser.createCampaign("Build a School", "A campaign to build a school.", payable(address(this)), 1 ether, 1 days);
//         vm.deal(address(1), 1 ether);
//         vm.prank(address(1));
//         fundraiser.donate{value: 0.5 ether}(0);

//         vm.warp(block.timestamp + 1 days); // Fast forward time to end the campaign
//         fundraiser.endCampaign(0);

//         (, , , , , uint amountRaised, bool ended) = fundraiser.campaigns(0);
//         assertEq(amountRaised, 0);
//         assertTrue(ended);
//     }
// }

//$ forge create --rpc-url https://eth-sepolia.g.alchemy.com/v2/Yjk3IhdnhlDW02VX3ZisAyplSnA9fRDZ--private-key cc6e41a721f9a7f70fdfc6365d9688ebbe46aeca6d0fa1f2fbebcbb2784f059c src/MyContract.sol:MyContract

// https://eth-sepolia.g.alchemy.com/v2/Yjk3IhdnhlDW02VX3ZisAyplSnA9fRDZ
// cc6e41a721f9a7f70fdfc6365d9688ebbe46aeca6d0fa1f2fbebcbb2784f059c
