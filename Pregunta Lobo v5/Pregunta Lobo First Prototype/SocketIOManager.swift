//
//  SocketIOManager.swift
//  SocketChat
//
//  Created by Amaury Rodriguez on 4/9/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import Foundation
import SocketIO

class SocketIOManager: NSObject {
    
    static let sharedInstance = SocketIOManager()
    let manager = SocketManager(socketURL: URL(string: "http://136.145.45.240:8080")!)
    
    var socket: SocketIOClient!
    
    override init() {
        super.init()
        
        self.socket = manager.defaultSocket
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func sendMessage(message: String) {
        print("Me llamaron")
        
        socket.on("connect") { _, _ in
            print("Socket Connected")
            self.socket.emit("message", message)
        }
        print("MESSAGE SENT!")
    }
    
} // class


