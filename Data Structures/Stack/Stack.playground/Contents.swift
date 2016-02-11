

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


var myStack = Stack<Int>()

myStack.pop()

myStack.push(5)
print(myStack.array)

myStack.peek()


myStack.push(10)
print(myStack.array)

myStack.peek()

myStack.pop()
print(myStack.array)



