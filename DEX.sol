// SPDX-License-Identifier: MIT

pragma solidity ^0.6.10;

import "https://github.com/Sanj96/Assignment5/blob/main/SafeYorkERC20Token.sol";

contract DEX {

    IERC20 public token;

    event Bought(uint256 amount);
    event Sold(uint256 amount);

    constructor() public {
        token = new YorkERC20Token();
    }
    
    function buy() payable public {
        
           //amount to buy
            uint256 amountTobuy = msg.value;
        
      	    //token balance
	    uint256 dexBalance = token.balanceOf(address(this));
	    
	    //Transaction should be greater than 0 
	    require(amountTobuy > 0, "You need to send some ether");
	    
	    //Checking if enough tokens are available
	    require(amountTobuy <= dexBalance, "Not enough tokens in the reserve");
	    
	     // transfer token to caller
	    token.transfer(msg.sender, amountTobuy);
	    
	    //emit the Transfer and Bought events
	    emit token.Transfer(address(this), msg.sender, amountTobuy);
	    emit Bought(amountTobuy);
    }
    
    function sell(uint256 amount) public {
        
            //Transaction of tokens should be greater than 0 
             require(amount > 0, "You need to sell at least some tokens");
        
            //Allowance 
            uint256 allowance = token.allowance(msg.sender, address(this));
        
            //check if allowance is greater than amount of tokens to sell
	    require(allowance >= amount, "Check the token allowance");
	    
	    //approval of transaction 
	    token.approve(msg.sender, _amount);
	    
	    //Checking if transfer is successful from caller address to contract address
	    token.transferFrom(msg.sender, address(this), amount);
	    
	    // send ether to caller
	    msg.sender.transfer(amount);
	    
	    //emit the Transfer and Sold events
	    emit token.Transfer(msg.sender, address(this),amount);
	    emit Sold(amount);
    }

}
