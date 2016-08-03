/// @title Implementation of a min-heap
/// @author Adrián Calvo (https://github.com/adrianclv)
library MinHeap{
    // Maximum number of elements allowed in the heap
    uint private constant MAX_ELEMS = 100;

    struct heap{
        // Array of elements with a size of (MAX_ELEMS + 1)
        uint[101] elems;
        uint numElems;
    }

    /// @notice Inserts the element `elem` in the heap
    /// @param elem Element to be inserted
    function insert(heap storage self, uint elem){
        if(self.numElems == MAX_ELEMS) throw;

        self.numElems++;
        self.elems[self.numElems] = elem;

        shiftUp(self, self.numElems);
    }

    /// @notice Deletes the element with the minimum value
    function deleteMin(heap storage self){
        if(self.numElems == 0) throw;

        deletePos(self, 1);
    }

    /// @notice Deletes the element in the position `pos`
    /// @param pos Position of the element to be deleted
    function deletePos(heap storage self, uint pos){
        if(self.numElems < pos) throw;

        self.elems[pos] = self.elems[self.numElems];
        delete self.elems[self.numElems];
        self.numElems--;

        shiftDown(self, pos);
    }

    /// @notice Returns the element with the minimum value
    /// @return The element with the minimum value
    function min(heap storage self) constant returns(uint){
        if(self.numElems == 0) throw;

        return self.elems[1];
    }

    /// @notice Checks if the heap is empty
    /// @return True if there are no elements in the heap
    function isEmpty(heap storage self) constant returns(bool){

        return (self.numElems == 0);
    }

    /* Private functions */

    // Move a element up in the tree
    // Used to restore heap condition after insertion
    function shiftUp(heap storage self, uint pos) private{
        uint copy = self.elems[pos];

        while(pos != 1 && copy < self.elems[pos/2]){
            self.elems[pos] = self.elems[pos/2];
            pos = pos/2;
        }
        self.elems[pos] = copy;
    }

    // Move a element down in the tree
    // Used to restore heap condition after deletion
    function shiftDown(heap storage self, uint pos) private{
        uint copy = self.elems[pos];
        bool isHeap = false;

        uint sibling = pos*2;
        while(sibling <= self.numElems && !isHeap){
            if(sibling != self.numElems && self.elems[sibling+1] < self.elems[sibling])
                sibling++;
            if(self.elems[sibling] < copy){
                self.elems[pos] = self.elems[sibling];
                pos = sibling;
                sibling = pos*2;
            }else{
                isHeap = true;
            }
        }
        self.elems[pos] = copy;
    }
}

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
