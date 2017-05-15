//
//  switchTableView.swift
//  Remote2
//
//  Created by CAM UPRA on 12/6/16.
//  Copyright © 2016 CAM UPRA. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SwitchTableViewController: UITableViewController {
    
    var objects: NSMutableArray! = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.objects.add("CAM")
        self.objects.add("CCOM")
        self.objects.add("Biblioteca")
        self.objects.add("Decanato")
        
        tableView.reloadData()



    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCells
        
        cell.topicLabel.text = self.objects.object(at: indexPath.row) as? String
        
        
        if cell.topicLabel.text == "CAM" {
            
            cell.topicSwitch.setOn(true, animated: true)
            cell.topicSwitch.isEnabled = false
            
            
        }
        
        cell.topicSwitch.tag = indexPath.row
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let title : String = "Topics"
        
        return title
    }
    
    
}
