//
//  TableViewCells.swift
//  Remote2
//
//  Created by CAM UPRA on 12/6/16.
//  Copyright © 2016 CAM UPRA. All rights reserved.
//

import Foundation
import UIKit
import Firebase

var count = 0

class TableViewCells: UITableViewCell {
    var topic:[Topics]? = nil
    
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var topicSwitch: UISwitch!
    let nvc = NotificationViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //topicSwitch.isOn = UserDefaults.standard.bool(forKey: "switchState")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        
    }
    
    @IBAction func subscribeTopic (sender: UISwitch) {
        
        UserDefaults.standard.set(topicSwitch.isOn, forKey: self.topicLabel.text!)
        
        if sender.isOn {
            
            Messaging.messaging().subscribe(toTopic: "/topics/\(self.topicLabel.text!)")
            print("/topics/\(self.topicLabel.text!)")
            TopicDataHandler.saveObject(topic: (self.topicLabel.text!))
            nvc.newTopic(topic: (self.topicLabel.text!).uppercased())

        } else {
            
            Messaging.messaging().unsubscribe(fromTopic: "/topics/\(self.topicLabel.text!)")
            print("/topics/\(self.topicLabel.text!)")
            topic = TopicDataHandler.filterData()
            for item in topic!{
                
                if(item.topic == (self.topicLabel.text!)){
                    break
                }
                count = count + 1
                }
            
            TopicDataHandler.deleteObject(topic: topic![count])
        }
        count = 0
    }
}
