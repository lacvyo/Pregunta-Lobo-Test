//
//  List.swift
//  Pregunta Lobo First Prototype
//
//  Created by Amaury Rodriguez on 10/20/15.
//  Copyright © 2015 Cheylianie Rivera. All rights reserved.
//

import Foundation

class List: NSObject {
    
    var head: Node!
    var temp: Node!
    var preTemp: Node!
    
    override init() {
        head = nil
        temp = nil
        preTemp = nil
    }
    
    func isEmpty() -> Bool {
        if head == nil {
            return true
        } else {
            return false
        }
    }
    
    func insertIntoList(_ aWord: String) {
        let node: Node! = Node()
        
        node.word = aWord
        node.next = nil
        
        if head != nil {
            temp = head
            while temp.next != nil {
                temp = temp.next
            }
            temp.next = node
        } else {
            head = node
        }
    }
    
    func isInListAndRemove(_ aWord: String) -> Bool {
        
        if head.word == aWord {
            temp = head
            head = temp.next
            return true
        } else {
            preTemp = head
            temp = head.next
            
            while temp != nil {
                if temp.word == aWord {
                    preTemp.next = temp.next
                    return true
                }
                preTemp = temp
                temp = temp.next
            }
        }
        return false
        }
    
    func removeAll() {
        head = nil
    }
    
    func displayList() {
        temp = head
        print("List:")
        while temp != nil {
            print("\(temp.word) ")
            temp = temp.next
        }
    }
    
}
