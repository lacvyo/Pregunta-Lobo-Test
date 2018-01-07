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
    //let socket = SocketIOClient(socketURL: URL(string: "http://136.145.45.240:3000")!)

    let manager = SocketManager(socketURL: URL(string: "http://136.145.45.240:3000")!)
    lazy var defaultSocket = self.manager.defaultSocket
    lazy var namespaceSocket = self.manager.socket(forNamespace: "/swift")
    
    
    override init() {
        super.init()
    }
    
    func establishConnection() {
        namespaceSocket.connect()
    }
    
    func closeConnection() {
        namespaceSocket.disconnect()
    }
    
    func sendMessage(message: String) {
        namespaceSocket.emit("message", message)
    }
    
}


