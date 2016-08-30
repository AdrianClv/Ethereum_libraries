# Ethereum_libraries
These libraries are only being developed as an example.

If you are thinking about using these libraries in your project, be careful, it is probably not a good idea, as these libraries use a lot of gas. A better approach would be to store your data in an array in the blockchain and sort it off-chain. 


## Example usage:
```javascript
import "https://github.com/adrianclv/Ethereum_libraries/minheap/minHeap.sol";

contract MinHeapExample{
    using MinHeap for MinHeap.heap;

    MinHeap.heap public minHeap;

    function test(){
        minHeap.insert(5);
        minHeap.insert(3);
        minHeap.insert(1);
        minHeap.insert(4);
        minHeap.deleteMin();
        minHeap.insert(2);
        minHeap.insert(8);
    }

    function show() constant returns(uint[101]){

        return minHeap.elems;
    }
}
```
