pragma solidity ^0.6.0;

contract MappingStructExample{
    mapping(address=>uint) public balanceRecevied;

    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }
    function sendMoney() public payable{
        balanceRecevied[msg.sender]+=msg.value;
    }

    function withdrawMoney(address payable _to,uint _amount) public{
        require(balanceRecevied[msg.sender]>=_amount,"not enough funds");
        balanceRecevied[msg.sender]-=_amount;
        _to.transfer(_amount);
    }
}
