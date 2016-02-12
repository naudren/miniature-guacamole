//
//  Stack.swift
//  Stack
//
//  Created by Nicolas Audren on 12/02/2016.
//  Copyright © 2016 Nicosoft. All rights reserved.
//

import Foundation

public struct Stack<T> {
    
    private var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    mutating func push( newElement: T ) {
        array.append(newElement)
    }
    
    mutating func pop() -> T? {
        if isEmpty {
            return nil
        }
        else {
            return array.removeLast()
        }
        
    }
    
    func peek() -> T? {
        
        return array.last
        
    }
}
