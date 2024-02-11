// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    uint256 public number;

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }

    function modExp(uint256 _b, uint256 _e, uint256 _m) public view returns (uint256 _o) {
        assembly {
            // define pointer
            let p := mload(0x40)
            // store data assembly-favouring ways
            mstore(p, 0x20)             // Length of Base
            mstore(add(p, 0x20), 0x20)  // Length of Exponent
            mstore(add(p, 0x40), 0x20)  // Length of Modulus
            mstore(add(p, 0x60), _b)  // Base
            mstore(add(p, 0x80), _e)     // Exponent
            mstore(add(p, 0xa0), _m)     // Modulus
            if iszero(staticcall(not(0), 0x05, p, 0xc0, p, 0x20)) {
                revert(0, 0)
            }
            // data
            _o := mload(p)
        }
    }

    function mudMult(uint256 x, uint256 y, uint256 k) public pure returns (uint256 result) {
        result = mulmod(x, y, k);
    }

    function genHash(uint256 g, uint256 y, uint256 t) public pure returns (uint o) {
        o = uint256(sha256(abi.encodePacked(g, y, t)));
    }
}
