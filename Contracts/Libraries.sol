pragma solidity ^0.5.11;
import "https://github.com/sbmeteturkay/solidity-samples/blob/main/Contracts/ModifierImport.sol";
    library Search {
        function indexOf(uint[] storage self, uint value)
        public
        view
        returns (uint)
        {
            for (uint i = 0; i < self.length; i++)
            if (self[i] == value) return i;
                return uint(-1);
        }
    }
    contract NotUsingForExample is Owned {
        uint[] data;
        function append(uint value) public {
            data.push(value);
        }
        function replace(uint _old, uint _new) public onlyOwner {
            // This performs the library function call
            uint index = Search.indexOf(data,_old);
            if (index == uint(-1))
                data.push(_new);
            else
                data[index] = _new;
        }
}
