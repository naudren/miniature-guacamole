

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


var myQueue: Queue<Int> = Queue<Int>(array: [])

myQueue.enqueue(5)
print(myQueue)
myQueue.enqueue(10)
myQueue.enqueue(3)

myQueue.peek()

myQueue.dequeue()
print(myQueue)

myQueue.peek()