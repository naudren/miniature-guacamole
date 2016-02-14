//
//  Heap.swift
//  Heap
//
//  Created by Nicolas Audren on 12/02/2016.
//  Copyright © 2016 Nicosoft. All rights reserved.
//

import Foundation

public struct Heap<T> {
    
    //MARK: properties
    var elements = [T]()
    private var sorter: (T,T) -> Bool //Comparison closure
    
    var count: Int {
        return elements.count
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    //MARK: public API
    
    public init(sort: (T,T) -> Bool ) {
        sorter = sort
    }
    
    public init(array: [T], sort: (T,T) -> Bool ) {
        sorter = sort
        buildHeap(array)
    }
    
    
    mutating func insert( newElement: T ) {
        elements.append(newElement)
        shiftUp(count-1)
    }
    
    mutating func insert( array: [T] ) {
        for value in array {
            insert(value)
        }
    }
    
    func peek() -> T? {
        if isEmpty {
            return nil
        }
        else {
            return elements.first
        }
    }
    
    mutating func remove() -> T? {
        if isEmpty {
            return nil
        }
        else {
            let first = elements.removeFirst()
            if !isEmpty {
                let last = elements.removeLast()
                
                elements.insert(last, atIndex: 0)
                
                shiftDown(0)
            }
            
            return first
        }
    }
    
    mutating func removeAtIndex(index: Int) -> T? {
        if index != count - 1 {
            swap(&elements[index], &elements[count-1])
            
            shiftDown(index)
            shiftUp(index)
        }
        return elements.removeLast()
    }
    
    mutating func replace(index: Int, value: T) {
        assert(sorter(value, elements[index]))
        elements[index] = value
        shiftUp(index)

    }
    
    
    func indexOfLeftChild(i: Int) -> Int {
        return 2*i + 1
    }
    
    func indexOfRightChild(i: Int) -> Int {
        return 2*i + 2
    }
    
    func indexOfParent(i: Int) -> Int {
        return (i - 1)/2
    }

    
    //MARK: internal
    
    //this is the naive approach. it works fine but takes O(nlogn) and the heap it builds is slightly different than
    //the optimized Floyd Algorithm one that the unit tests expect so they fail
//    private mutating func buildHeap(array: [T]) {
//        for value in array {
//            insert(value)
//        }
//    }
    
    //using the Floyd Algorithm for efficiency
    private mutating func buildHeap(array: [T]) {
        elements = array
        for var i = (count/2 - 1);i>=0;--i {
            shiftDown(i)
        }
    }
    
    
    private mutating func shiftUp(index: Int) {
        let parentIndex = indexOfParent(index)
        if parentIndex != index {
            let parentValue = elements[parentIndex]
            let currentValue = elements[index]
            
            if sorter(parentValue,currentValue) == false {
                elements[parentIndex] = currentValue
                elements[index] = parentValue
                shiftUp(parentIndex)
            }
        }
    }
    
    private mutating func shiftDown(index: Int) {
        let currentValue = elements[index]
        
        let leftChildIndex = indexOfLeftChild(index)
        let rightChildIndex = indexOfRightChild(index)
        
        var leftChildValue: T?
        if leftChildIndex < count {
            leftChildValue = elements[leftChildIndex]
        }
        
        var rightChildValue: T?
        if rightChildIndex < count {
            rightChildValue = elements[rightChildIndex]
        }
        
        var candidateToSwapIndex = leftChildIndex
        if var candidateToSwapValue = leftChildValue  {
            if (rightChildValue != nil) {
                if sorter( rightChildValue!, leftChildValue! ) {
                    candidateToSwapValue =  rightChildValue!
                    candidateToSwapIndex = rightChildIndex
                }
            }
            
            if sorter(candidateToSwapValue,currentValue) {
                elements[candidateToSwapIndex] = currentValue
                elements[index] = candidateToSwapValue
                shiftDown(candidateToSwapIndex)
            }
        }
        
    }
}