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

class TableViewCells: UITableViewCell {
    
    
    
    
    @IBOutlet weak var topicLabel: UILabel!
    
    
    @IBOutlet weak var topicSwitch: UISwitch!
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        topicSwitch.isOn = UserDefaults.standard.bool(forKey: "switchState")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        
    }
    
    @IBAction func subscribeTopic (sender: UISwitch) {
        
        
        UserDefaults.standard.set(topicSwitch.isOn, forKey: "switchState")
        
        if sender.isOn {
            
            Messaging.messaging().subscribe(toTopic: "/topics/\(self.topicLabel.text!)")
            print("/topics/\(self.topicLabel.text!)")
        } else {
            
            Messaging.messaging().unsubscribe(fromTopic: "/topics/\(self.topicLabel.text!)")
            print("/topics/\(self.topicLabel.text!)")
        }
        
        
    }
}
