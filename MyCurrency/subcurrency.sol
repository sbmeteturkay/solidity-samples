pragma solidity >=0.7.0 <=0.9.0;
//SPDX-License-Identifier: UNLICENSED

//The contract allows only its creator to create new coins

contract Coin{
    uint totalSupply;
    address public minter;
    mapping (address =>uint) public balances;

    modifier onlyOwner{
        require(msg.sender == minter, "You are not allowed to that.");
        _;
    }
    event Sent(address from, address to, uint amount);

    //constructor only runs when we deploy contract
    constructor(){
        minter=msg.sender;
    }
    //make nw coins and send them to address
    // only the owner can send these coins
    function mint(address _receiver, uint _amount) public onlyOwner{
        balances[_receiver]+=_amount;
    }
    function setTotalSupply(uint _amount)public onlyOwner{
        assert(_amount>totalSupply);
        totalSupply=_amount;
    }

    error insufficientBalance(uint requested,uint available);

    function send(address _receiver, uint _amount) public{
        if(_amount>balances[msg.sender])
        revert insufficientBalance({
            requested: _amount,
            available: balances[msg.sender]
        });
        balances[msg.sender]-=_amount;
        balances[_receiver]+=_amount;
        emit Sent(msg.sender,_receiver,_amount);
    }
}