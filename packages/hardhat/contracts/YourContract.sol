pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract YourContract {

  event SetPurpose(address sender, string purpose);
  
  address private ourWallet = 0xFB4aac4fe126C74d5133B3289e661C674b7854aa;
  uint256 ticketPrice = 1 ether;

  address[] private participants;


  constructor() payable {
    // what should we do on deploy?
  }

  function optIn() public payable {
    // validate value sent. If they send more, lucky us.
    require(msg.value >= ticketPrice, "Ticket price is 1 ETH!");

    // Add sender to participants
    participants.push(msg.sender);
  
  }

  function draw() public {
    // At least 2 participants
    require(participants.length >= 2, "Too few participants");
    // Optional: At least 2 unique participants

    // Calculate the reward: Number of participants * 0.6
    uint reward = (participants.length * 60 * 1 ether)/100;
    console.log("Rewards: ", reward);
    // Send reward to the winning participant from our wallet
    payable(participants[0]).transfer(reward);
    delete participants;
  }

  function wallet() public view returns(uint) {
    return address(this).balance;
  }
  // to support receiving ETH by default
  receive() external payable {}
  fallback() external payable {}
}
