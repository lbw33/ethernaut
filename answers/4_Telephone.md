# 4. Telephone
*Please see contracts/4_Telephone.sol & contracts/4_TelephoneAttack.sol*

Open up the developer console.
Open up Remix and deploy the Telephone contract at the address specified in the developer console.

___
## 1. Initial Considerations & Methodology

In this level the only requirement is that we take control of the Telephone contract. The only part in the contract that we are concerned with it the ```changeOwner(address _owner)``` function.  
The main challenge to solve with this level is how to call a contract from another address than your own.

___
## 2. How To Complete

Call ```changeOwner()```.

___
### 1. Call the changeOwner() function
As stated prviously, the issue with this challenge is to call this function and have the ```tx.origin``` and ```msg.sender``` to be different.  

The ```tx.origin``` global variable refers to the original external account that started the transaction while ```msg.sender``` refers to the immediate account (it could be external or another contract account) that invokes the function.  

This means that if we call the ```changeOwner()``` function from a contract, the ```tx.origin``` will be the contract address and ```msg.sender``` will be passed in as the player address.  

The function looks like this:
```
function attackVictim() public {
  victimContract.changeOwner(owner);
}
```
This will cause the  if statement in the following code block to evaluate to true and therefore change the owner.
```
if (tx.origin != msg.sender) {
  owner = _owner;
}
```
This should transfer the ownership of contract to the player address.

**YOU CAN NOW SUBMIT THE ANSWER AND HAVE NOW COMPLETED THIS LEVEL**
