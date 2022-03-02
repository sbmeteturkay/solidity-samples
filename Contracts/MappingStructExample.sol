pragma solidity ^0.6.0;

contract MappingStructExample{

    struct Payment{
        uint _amount;
        uint timestamps;
    }

    struct Balance{
        uint totalBalance;
        uint numPayments;
        mapping(uint => Payment) payments;
    }

    mapping(address=>Balance) public balanceRecevied;

    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }
    function sendMoney() public payable{
        //user send money action
        balanceRecevied[msg.sender].totalBalance+=msg.value;
        //we store details of action
        Payment memory payments = Payment(msg.value,now);
        //we write this data to users address
        balanceRecevied[msg.sender].payments[balanceRecevied[msg.sender].numPayments] = payments;
        //we increase the payments index to write data to the next one
        balanceRecevied[msg.sender].numPayments++;
    }

    function withdrawMoney(address payable _to,uint _amount) public{
        require(balanceRecevied[msg.sender].totalBalance>=_amount,"not enough funds");
        balanceRecevied[msg.sender].totalBalance-=_amount;
        _to.transfer(_amount);
    }
    function withdrawAllMoney(address payable _to) public{
        uint balanceToSend = balanceRecevied[msg.sender].totalBalance;
        balanceRecevied[msg.sender].totalBalance=0;
        _to.transfer(balanceToSend);
        msg.sender.transfer(balanceToSend);
    }
        function withdrawAllMoneyToMe() public{
        //why we just transfer balanceRecevied[msg.sender].totalBalance? beacuse we need to decrease value before the transfer
        uint balanceToSend = balanceRecevied[msg.sender].totalBalance;
        balanceRecevied[msg.sender].totalBalance=0;
        msg.sender.transfer(balanceToSend);
    }
}
