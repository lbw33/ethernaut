# 2. Fallout

Open the developer console.

___
## 1. Initial Considerations & Methodology

This level is extremely simple however there are a few gotchas that need to be addressed.  
Essentially we need to trigger the "constructor" of the contract after it has been called in order to change the owner:
```
/* constructor */
  function Fal1out() public payable {
    owner = msg.sender;
    allocations[owner] = msg.value;
  }
```


___
## 2. How To Complete

Call ```Fal1out```.

___
### 1. Call the Fal1out function
One of the main gotchas with this is that even though the comment states that it is a constructor, it is just a normal function.   
Therefore it can be called after the contract has been instantiated.  
  
The second gotcha with this is the name of the function itself. The function is not called ```Fallout```, it is called ```Fal1out``` ~ the last 'l' is actually a 1.  
In the developer console type:  
```
await contract.fal1out();
```
This should transfer the ownership of contract to the player address.

**YOU CAN NOW SUBMIT THE ANSWER AND HAVE NOW COMPLETED THIS LEVEL**
