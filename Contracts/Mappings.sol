pragma solidity ^0.6.0;

contract SimpleMappingExample{

//this can be used for whitelisting maybe?
    address owner;
    constructor()public{
        owner=msg.sender;
    }

    mapping(uint => bool) myMapping;
    mapping(address=>bool) whiteListed;

    function setValue(uint _index) public{
        myMapping[_index]=true;
    }

    function setWhiteListed(address _address,bool _listed)public{
        require(owner==msg.sender);
        whiteListed[_address]=_listed;
    }
    function checkWhiteList() public view returns(bool){
        return whiteListed[msg.sender];
    }

}