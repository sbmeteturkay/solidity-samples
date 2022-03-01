pragma solidity ^0.5.11;

contract SendMoneyExample{

    uint public balanceRecevied;

    function recevieMoney() public payable{
        balanceRecevied+= msg.value;
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function withdrawMoney() public{
        address payable to = msg.sender;
        to.transfer(this.getBalance());
    }

    function withdrawMoneyTo(address payable _to,address payable _to2)public{
        _to.transfer(this.getBalance()/2);
        _to2.transfer(this.getBalance());
    }
}