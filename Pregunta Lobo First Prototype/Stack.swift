//
//  Stack.swift
//  Pregunta Lobo First Prototype
//
//  Created by Amaury Rodriguez on 10/20/15.
//  Copyright © 2015 Cheylianie Rivera. All rights reserved.
//

import Foundation

class Stack: NSObject {
    
    var top: Node!
    var popValue: Node!
    var displayStack: Node!
    
    override init() {
        top = nil
        popValue = nil
        displayStack = nil
    }
    
    func isEmpty() -> Bool {
        if top == nil {
            return true
        } else {
            return false
        }
    }
    
    func push(_ aWord: String) {
        let node: Node! = Node()
        node.word = aWord
        node.next = top
        top = node
    }
    
    func pop() {
        if isEmpty() != true {
            popValue = top
            top = top.next
        }
    }
    
    func lookTop() -> String {
        return top.word
    }
    
    func deleteAll() {
        top = nil
    }
    
    func display() {
        displayStack = top
        print("Stack:")
        while displayStack != nil {
            print("\(displayStack.word) ")
            displayStack = displayStack.next
        }
    }
}
