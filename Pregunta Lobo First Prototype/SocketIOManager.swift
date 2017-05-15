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
    //var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://136.145.45.240:3000")! as URL)
    let socket = SocketIOClient(socketURL: URL(string: "http://136.145.45.240:3000")!)
        
    override init() {
        super.init()
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func sendMessage(message: String) {
        socket.emit("message", message)
    }
    
}


