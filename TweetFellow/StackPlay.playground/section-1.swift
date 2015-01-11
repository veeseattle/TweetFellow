// Playground - noun: a place where people can play

import UIKit

//Implement a stack data structure in a separate playground

class Stack {
  
  var stackArray : [Int] = [Int]()
  
  
  func push(item: Int) {
    self.stackArray.append(item)
  }
  
  func pop() -> Int? {
    if !self.stackArray.isEmpty {
      var tempItem = self.stackArray.last!
      self.stackArray.removeLast()
      return tempItem
    }
    else {
      println("The stack is empty")
      return nil
    }
  }
  
  
  func peek() -> Int? {
    return self.stackArray.last
  }
}


