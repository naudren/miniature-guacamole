//
//  HeapTests.swift
//  HeapTests
//
//  Created by Nicolas Audren on 12/02/2016.
//  Copyright © 2016 Nicosoft. All rights reserved.
//

import XCTest
@testable import Heap

class HeapTests: XCTestCase {
    
    private func verifyMaxHeap(h: Heap<Int>) -> Bool {
        for i in 0..<h.count {
            let left = h.indexOfLeftChild(i)
            let right = h.indexOfRightChild(i)
            let parent = h.indexOfParent(i)
            if left < h.count && h.elements[i] < h.elements[left] { return false }
            if right < h.count && h.elements[i] < h.elements[right] { return false }
            if i > 0 && h.elements[parent] < h.elements[i] { return false }
        }
        return true
    }
    
    private func verifyMinHeap(h: Heap<Int>) -> Bool {
        for i in 0..<h.count {
            let left = h.indexOfLeftChild(i)
            let right = h.indexOfRightChild(i)
            let parent = h.indexOfParent(i)
            if left < h.count && h.elements[i] > h.elements[left] { return false }
            if right < h.count && h.elements[i] > h.elements[right] { return false }
            if i > 0 && h.elements[parent] > h.elements[i] { return false }
        }
        return true
    }
    
    private func isPermutation(array1: [Int], _ array2: [Int]) -> Bool {
        var a1 = array1
        var a2 = array2
        if a1.count != a2.count { return false }
        while a1.count > 0 {
            if let i = a2.indexOf(a1[0]) {
                a1.removeAtIndex(0)
                a2.removeAtIndex(i)
            } else {
                return false
            }
        }
        return a2.count == 0
    }
    
    func testEmptyHeap() {
        var heap = Heap<Int>(sort: <)
        XCTAssertTrue(heap.isEmpty)
        XCTAssertEqual(heap.count, 0)
        XCTAssertNil(heap.peek())
        XCTAssertNil(heap.remove())
    }
    
    func testIsEmpty() {
        var heap = Heap<Int>(sort: >)
        XCTAssertTrue(heap.isEmpty)
        heap.insert(1)
        XCTAssertFalse(heap.isEmpty)
        heap.remove()
        XCTAssertTrue(heap.isEmpty)
    }
    
    func testCount() {
        var heap = Heap<Int>(sort: >)
        XCTAssertEqual(0, heap.count)
        heap.insert(1)
        XCTAssertEqual(1, heap.count)
    }
    
    func testMaxHeapOneElement() {
        let heap = Heap<Int>(array: [10], sort: >)
        XCTAssertTrue(verifyMaxHeap(heap))
        XCTAssertTrue(verifyMinHeap(heap))
        XCTAssertFalse(heap.isEmpty)
        XCTAssertEqual(heap.count, 1)
        XCTAssertEqual(heap.peek()!, 10)
    }
    
    func testCreateMaxHeap() {
        let h1 = Heap(array: [1, 2, 3, 4, 5, 6, 7], sort: >)
        XCTAssertTrue(verifyMaxHeap(h1))
        XCTAssertFalse(verifyMinHeap(h1))
        XCTAssertEqual(h1.elements, [7, 5, 6, 4, 2, 1, 3])
        XCTAssertFalse(h1.isEmpty)
        XCTAssertEqual(h1.count, 7)
        XCTAssertEqual(h1.peek()!, 7)
        
        let h2 = Heap(array: [7, 6, 5, 4, 3, 2, 1], sort: >)
        XCTAssertTrue(verifyMaxHeap(h2))
        XCTAssertFalse(verifyMinHeap(h2))
        XCTAssertEqual(h2.elements, [7, 6, 5, 4, 3, 2, 1])
        XCTAssertFalse(h2.isEmpty)
        XCTAssertEqual(h2.count, 7)
        XCTAssertEqual(h2.peek()!, 7)
        
        let h3 = Heap(array: [4, 1, 3, 2, 16, 9, 10, 14, 8, 7], sort: >)
        XCTAssertTrue(verifyMaxHeap(h3))
        XCTAssertFalse(verifyMinHeap(h3))
        XCTAssertEqual(h3.elements, [16, 14, 10, 8, 7, 9, 3, 2, 4, 1])
        XCTAssertFalse(h3.isEmpty)
        XCTAssertEqual(h3.count, 10)
        XCTAssertEqual(h3.peek()!, 16)
        
        let h4 = Heap(array: [27, 17, 3, 16, 13, 10, 1, 5, 7, 12, 4, 8, 9, 0], sort: >)
        XCTAssertTrue(verifyMaxHeap(h4))
        XCTAssertFalse(verifyMinHeap(h4))
        XCTAssertEqual(h4.elements, [27, 17, 10, 16, 13, 9, 1, 5, 7, 12, 4, 8, 3, 0])
        XCTAssertFalse(h4.isEmpty)
        XCTAssertEqual(h4.count, 14)
        XCTAssertEqual(h4.peek()!, 27)
    }
    
    func testCreateMinHeap() {
        let h1 = Heap(array: [1, 2, 3, 4, 5, 6, 7], sort: <)
        XCTAssertTrue(verifyMinHeap(h1))
        XCTAssertFalse(verifyMaxHeap(h1))
        XCTAssertEqual(h1.elements, [1, 2, 3, 4, 5, 6, 7])
        XCTAssertFalse(h1.isEmpty)
        XCTAssertEqual(h1.count, 7)
        XCTAssertEqual(h1.peek()!, 1)
        
        let h2 = Heap(array: [7, 6, 5, 4, 3, 2, 1], sort: <)
        XCTAssertTrue(verifyMinHeap(h2))
        XCTAssertFalse(verifyMaxHeap(h2))
        XCTAssertEqual(h2.elements, [1, 3, 2, 4, 6, 7, 5])
        XCTAssertFalse(h2.isEmpty)
        XCTAssertEqual(h2.count, 7)
        XCTAssertEqual(h2.peek()!, 1)
        
        let h3 = Heap(array: [4, 1, 3, 2, 16, 9, 10, 14, 8, 7], sort: <)
        XCTAssertTrue(verifyMinHeap(h3))
        XCTAssertFalse(verifyMaxHeap(h3))
        XCTAssertEqual(h3.elements, [1, 2, 3, 4, 7, 9, 10, 14, 8, 16])
        XCTAssertFalse(h3.isEmpty)
        XCTAssertEqual(h3.count, 10)
        XCTAssertEqual(h3.peek()!, 1)
        
        let h4 = Heap(array: [27, 17, 3, 16, 13, 10, 1, 5, 7, 12, 4, 8, 9, 0], sort: <)
        XCTAssertTrue(verifyMinHeap(h4))
        XCTAssertFalse(verifyMaxHeap(h4))
        XCTAssertEqual(h4.elements, [0, 4, 1, 5, 12, 8, 3, 16, 7, 17, 13, 10, 9, 27])
        XCTAssertFalse(h4.isEmpty)
        XCTAssertEqual(h4.count, 14)
        XCTAssertEqual(h4.peek()!, 0)
    }
    
    func testCreateMaxHeapEqualElements() {
        let heap = Heap(array: [1, 1, 1, 1, 1], sort: >)
        XCTAssertTrue(verifyMaxHeap(heap))
        XCTAssertTrue(verifyMinHeap(heap))
        XCTAssertEqual(heap.elements, [1, 1, 1, 1, 1])
    }
    
    func testCreateMinHeapEqualElements() {
        let heap = Heap(array: [1, 1, 1, 1, 1], sort: <)
        XCTAssertTrue(verifyMinHeap(heap))
        XCTAssertTrue(verifyMaxHeap(heap))
        XCTAssertEqual(heap.elements, [1, 1, 1, 1, 1])
    }
    
    private func randomArray(n: Int) -> [Int] {
        var a = [Int]()
        for _ in 0..<n {
            a.append(Int(arc4random()))
        }
        return a
    }
    
    func testCreateRandomMaxHeap() {
        for n in 1...40 {
            let a = randomArray(n)
            let h = Heap(array: a, sort: >)
            XCTAssertTrue(verifyMaxHeap(h))
            XCTAssertFalse(h.isEmpty)
            XCTAssertEqual(h.count, n)
            XCTAssertTrue(isPermutation(a, h.elements))
        }
    }
    
    func testCreateRandomMinHeap() {
        for n in 1...40 {
            let a = randomArray(n)
            let h = Heap(array: a, sort: <)
            XCTAssertTrue(verifyMinHeap(h))
            XCTAssertFalse(h.isEmpty)
            XCTAssertEqual(h.count, n)
            XCTAssertTrue(isPermutation(a, h.elements))
        }
    }
    
    func testRemoving() {
        var h = Heap(array: [100, 50, 70, 10, 20, 60, 65], sort: >)
        XCTAssertTrue(verifyMaxHeap(h))
        XCTAssertEqual(h.elements, [100, 50, 70, 10, 20, 60, 65])
        
        let v1 = h.removeAtIndex(5)
        XCTAssertEqual(v1, 60)
        XCTAssertTrue(verifyMaxHeap(h))
        XCTAssertEqual(h.elements, [100, 50, 70, 10, 20, 65])
        
        let v2 = h.removeAtIndex(4)
        XCTAssertEqual(v2, 20)
        XCTAssertTrue(verifyMaxHeap(h))
        XCTAssertEqual(h.elements, [100, 65, 70, 10, 50])
        
        let v3 = h.removeAtIndex(4)
        XCTAssertEqual(v3, 50)
        XCTAssertTrue(verifyMaxHeap(h))
        XCTAssertEqual(h.elements, [100, 65, 70, 10])
        
        let v4 = h.removeAtIndex(0)
        XCTAssertEqual(v4, 100)
        XCTAssertTrue(verifyMaxHeap(h))
        XCTAssertEqual(h.elements, [70, 65, 10])
        
        XCTAssertEqual(h.peek()!, 70)
        let v5 = h.remove()
        XCTAssertEqual(v5, 70)
        XCTAssertTrue(verifyMaxHeap(h))
        XCTAssertEqual(h.elements, [65, 10])
        
        XCTAssertEqual(h.peek()!, 65)
        let v6 = h.remove()
        XCTAssertEqual(v6, 65)
        XCTAssertTrue(verifyMaxHeap(h))
        XCTAssertEqual(h.elements, [10])
        
        XCTAssertEqual(h.peek()!, 10)
        let v7 = h.remove()
        XCTAssertEqual(v7, 10)
        XCTAssertTrue(verifyMaxHeap(h))
        XCTAssertEqual(h.elements, [])
        
        XCTAssertNil(h.peek())
    }
    
    func testRemoveEmpty() {
        var heap = Heap<Int>(sort: >)
        let removed = heap.remove()
        XCTAssertNil(removed)
    }
    
    func testRemoveRoot() {
        var h = Heap(array: [15, 13, 9, 5, 12, 8, 7, 4, 0, 6, 2, 1], sort: >)
        XCTAssertTrue(verifyMaxHeap(h))
        XCTAssertEqual(h.elements, [15, 13, 9, 5, 12, 8, 7, 4, 0, 6, 2, 1])
        XCTAssertEqual(h.peek()!, 15)
        let v = h.remove()
        XCTAssertEqual(v, 15)
        XCTAssertTrue(verifyMaxHeap(h))
        XCTAssertEqual(h.elements, [13, 12, 9, 5, 6, 8, 7, 4, 0, 1, 2])
    }
    
    func testRemoveRandomItems() {
        for n in 1...40 {
            var a = randomArray(n)
            var h = Heap(array: a, sort: >)
            XCTAssertTrue(verifyMaxHeap(h))
            XCTAssertTrue(isPermutation(a, h.elements))
            
            let m = (n + 1)/2
            for k in 1...m {
                let i = Int(arc4random_uniform(UInt32(n - k + 1)))
                let v = h.removeAtIndex(i)!
                let j = a.indexOf(v)!
                a.removeAtIndex(j)
                
                XCTAssertTrue(verifyMaxHeap(h))
                XCTAssertEqual(h.count, a.count)
                XCTAssertEqual(h.count, n - k)
                XCTAssertTrue(isPermutation(a, h.elements))
            }
        }
    }
    
    func testInsert() {
        var h = Heap(array: [15, 13, 9, 5, 12, 8, 7, 4, 0, 6, 2, 1], sort: >)
        XCTAssertTrue(verifyMaxHeap(h))
        XCTAssertEqual(h.elements, [15, 13, 9, 5, 12, 8, 7, 4, 0, 6, 2, 1])
        
        h.insert(10)
        XCTAssertTrue(verifyMaxHeap(h))
        XCTAssertEqual(h.elements, [15, 13, 10, 5, 12, 9, 7, 4, 0, 6, 2, 1, 8])
    }
    
    func testInsertArrayAndRemove() {
        var heap = Heap<Int>(sort: >)
        heap.insert([1, 3, 2, 7, 5, 9])
        XCTAssertEqual(heap.elements, [9, 5, 7, 1, 3, 2])
        
        XCTAssertEqual(9, heap.remove())
        XCTAssertEqual(7, heap.remove())
        XCTAssertEqual(5, heap.remove())
        XCTAssertEqual(3, heap.remove())
        XCTAssertEqual(2, heap.remove())
        XCTAssertEqual(1, heap.remove())
        XCTAssertNil(heap.remove())
    }
    
    func testReplace() {
        var h = Heap(array: [16, 14, 10, 8, 7, 9, 3, 2, 4, 1], sort: >)
        XCTAssertTrue(verifyMaxHeap(h))
        XCTAssertEqual(h.elements, [16, 14, 10, 8, 7, 9, 3, 2, 4, 1])
        
        h.replace(5, value: 13)
        XCTAssertTrue(verifyMaxHeap(h))
        XCTAssertEqual(h.elements, [16, 14, 13, 8, 7, 10, 3, 2, 4, 1])
    }
    
}
