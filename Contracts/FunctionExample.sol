pragma solidity ^0.8.0;
//SPDX-License-Identifier: UNLICENSED

//we can see the use cases of require and assert in this contract

//fallback function used
contract FunctionExample{

    mapping(address=>uint) public balanceRecevied;

    address public owner;

    constructor(){
        owner = msg.sender;
    }

    //The pure functions do not read or modify the state variables, which returns the values 
    //only using the parameters passed to the function or local variables present in it.
    // basically not reading or modifiying any state
    //view and pure dont need to mine in blockchain
    function convertWeiToEther(uint _amountInWei) public pure returns(uint){
        return _amountInWei/1 ether;
    }

    function destroySmartContract() public{
        require(msg.sender==owner, "You are not the owner");
        selfdestruct(payable(owner));
    }

    function recevieMoney() public payable {
        //balance will always be bigger than our balance + our pay, this check means we cant pay "negative" value
        assert(balanceRecevied[msg.sender]+msg.value>=balanceRecevied[msg.sender]);
        balanceRecevied[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _to, uint _amount) public{
        //balance needs to bigger or equal to withdraw
        require(_amount <= balanceRecevied[msg.sender],"not enough funds");
        //our withdraw money should be not bigger than our balance
        assert(balanceRecevied[msg.sender]>=balanceRecevied[msg.sender] - _amount);
        balanceRecevied[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
    //fallback
    fallback() external payable{
        recevieMoney();
    }
    receive() external payable {
        recevieMoney();
        // custom function code
    }
}