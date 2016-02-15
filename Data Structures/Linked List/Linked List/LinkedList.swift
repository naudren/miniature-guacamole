//
//  LinkedList.swift
//  Linked List
//
//  Created by Nicolas Audren on 15/02/2016.
//  Copyright © 2016 Nicosoft. All rights reserved.
//

import Foundation

public class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode?
    var previous: LinkedListNode?
    
    public init(value: T) {
        self.value = value
    }
}

public class LinkedList<T> {
    public typealias Node = LinkedListNode<T>
    
    var first: Node?
    var last: Node?
    
    var isEmpty: Bool {
        return first == nil
    }
    
    var count: Int {
        print("Count:")
        var currentNode = first
        var currentCount = 0;
        while currentNode != nil {
            currentCount++
            print(currentNode?.value)
            currentNode = currentNode?.next
        }
        
        return currentCount
    }
    
    func append(newElement: T) {
        let node = Node(value: newElement)
        if let lastNode = last {
            lastNode.next = node
            node.previous = lastNode
            last = node
        }
        else {
            first = node
            last = node
        }
    }
    
    func nodeAtIndex(index: Int) -> Node? {
        var currentNode = first
        var currentIndex = 0;
        while currentNode != nil {
            if index == currentIndex {
                return currentNode
            }
            currentIndex++
            currentNode = currentNode?.next
        }
        
        return nil
    }
    
    public subscript(index: Int) -> T {
        let node = nodeAtIndex(index)
        return node!.value
    }
    
    func previousAndNextNodes(index: Int) -> (Node?, Node?) {
        let node = nodeAtIndex(index)
        return (node?.previous, node)
    }
    
    func insert(value: T, atIndex: Int) {
        let (prev,next) = previousAndNextNodes(atIndex)
        let node = Node(value: value)
        
        node.previous = prev
        node.next = next
        next?.previous = node
        prev?.next = node
        
        if prev == nil {
            first = node
        }
        
        if next == nil {
            last = node
        }
    }
    
    func removeAll() {
        first = nil
        last = nil 
    }
    
    func removeNode(node: Node) -> T {
        if let previous = node.previous {
            previous.next = node.next
        }
        else {
            first = node.next
        }
        if let next = node.next {
            next.previous = node.previous
        }
        else {
            last = node.previous
        }
        node.next = nil
        node.previous = nil
        return node.value
    }
    
    func removeAtIndex(index: Int) -> T? {
        if let node = nodeAtIndex(index) {
            return removeNode(node)
        }
        return nil
    }
    
    func removeLast() -> T? {
        if let node = last {
            return removeNode(node)
        }
        return nil
    }
    
    func reverse() {
        var currentNode = first
        let firstNode = first
        while currentNode != nil {
            swap(&currentNode!.next, &currentNode!.previous)
            first = currentNode
            currentNode = currentNode!.previous
        }
        last = firstNode
        
    }
}