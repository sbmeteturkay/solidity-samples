pragma solidity ^0.4.18;

import "./ExampleToken.sol";



contract Game is ExampleToken{
event Winner(address winner,uint amount, bool win);
  function random() private view returns (uint) {
        // sha3 and now have been deprecated
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, block.difficulty+block.timestamp)))%6;
        // convert hash to integer
        // players is an array of entrants
    }

    function PlayGame() public{
        uint number=random(); 
        if(number==1)
            emit Winner(msg.sender,number,true);
        else
            emit Winner(msg.sender,number,false);
    }
}