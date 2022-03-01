pragma solidity ^0.5.11;

contract StartStop{
    address owner;

    bool paused;
    uint public balanceRecevied;
    constructor() public{
        owner=msg.sender;
    }
    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function SendMoneyExample() public payable{
        require(paused!=true,"you cannot do this because contract is paused");
        balanceRecevied+= msg.value;
    }
    function checkOwner()public view returns(address){
        return owner;
    }
    function setPaused(bool _paused) public{
        require(msg.sender==owner,"not the owner");
        paused=_paused;
    }
    function withdrawMoneyIfOwner(address payable _to) public{
        require(msg.sender==owner,"You are not the owner");
        _to.transfer(address(this).balance);
    }
    function destroySmartContract(address payable _to) public{
        require(msg.sender==owner,"You are not the owner");
        selfdestruct(_to);
    }
    function withdrawMoney() public{
        address payable to = msg.sender;
        to.transfer(this.getBalance());
    }

}