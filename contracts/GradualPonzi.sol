pragma solidity ^0.8.4;

contract GradualPonzi {
    address[] public investors;
    mapping(address => uint256) balances;
    uint256 MINIMUM_INVESTMENT = 1 ether;

    constructor() {
        investors.push(msg.sender);
    }

    function invest() public payable {
        require(msg.value > MINIMUM_INVESTMENT);
        uint256 eachInvestor = msg.value / investors.length;
        for (uint256 i = 0; i < investors.length; i++) {
            balances[investors[i]] += eachInvestor;
        }
        investors.push(msg.sender);
    }

    function withdraw() public {
        uint256 payout = balances[msg.sender];
        balances[msg.sender] = 0;
        payable(msg.sender).transfer(payout);
    }
}
