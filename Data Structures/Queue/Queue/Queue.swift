//
//  Queue.swift
//  Queue
//
//  Created by Nicolas Audren on 12/02/2016.
//  Copyright © 2016 Nicosoft. All rights reserved.
//

import Foundation

public struct Queue<T> {
    
    var array = [T]()
    
    var isEmpty : Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    mutating func enqueue( newElement: T ) {
        array.append(newElement)
    }
    
    mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        }
            
        else {
            return array.removeFirst()
        }
        
    }
    
    func peek() -> T? {
        if isEmpty {
            return nil
        }
        else {
            return array.first
        }
    }
    
}
