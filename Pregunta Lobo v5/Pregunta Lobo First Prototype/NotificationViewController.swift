//
//  NotificationViewController.swift
//  Pregunta Lobo
//
//  Created by CAM UPRA on 4/9/18.
//  Copyright © 2018 Cheylianie Rivera. All rights reserved.
//

import UIKit
import Firebase

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblInfo: UITableView!
    
    var user:[Notification]? = nil
    var topics:[Topics]? = nil
    
    //var topics:[Topics]? = nil
    var info = [NotificationModel]()
    var refInfo: DatabaseReference!
    var refHandle: DatabaseHandle?

   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! viewControllerTableViewCell
        let notification: NotificationModel
        
        notification = info[indexPath.row]
        
        cell.lblDepartamento.text = "Departamento: " + notification.departamento!
        cell.lblTitle.text = "Titulo: " + notification.title!
        cell.lblMessage.text = "Mensaje: " + notification.message!
        cell.selectionStyle = .none
        return cell
        
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        topics = TopicDataHandler.filterData()
        
        for topic in topics!
        {
            print(topic.topic!)
            fetchData(topic: topic.topic!)
        }

        self.tblInfo.reloadData()
   
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
 
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func fetchData(topic: String){

        refInfo = Database.database().reference().child("Notification").child(topic)
        refInfo.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0{
                
                self.info.removeAll()
                
                for message in snapshot.children.allObjects as! [DataSnapshot]{
                    
                    let infoObject = message.value as? [String: AnyObject]
                    let messageId = message.key
                    let messageDepartamento = infoObject?["DEPARTAMENTO"]
                    let messageTitle = infoObject?["TITULO"]
                    let messageBody = infoObject?["MENSAJE"]

                    if(UserDefaults.standard.bool(forKey: "launched") == false){
                        print("New notifications downloaded")
                        CoreDataHandler.saveObject(id: (messageId as String?)!, department: (messageDepartamento as! String?)!, title: (messageTitle as! String?)!, message: (messageBody as! String?)!, active: false)
                    }
                    if((self.checkDB(id: (messageId as String?)!) == false))
                    {
                        CoreDataHandler.saveObject(id: (messageId as String?)!, department: (messageDepartamento as! String?)!, title: (messageTitle as! String?)!, message: (messageBody as! String?)!, active: true)

                    }
   
                }
                UserDefaults.standard.set(true, forKey: "launched")
                self.present()
                self.info.reverse()
            }
        })
    }
    
    // insert data into array that will be presented
    func present()
    {
        user = CoreDataHandler.filterData()
        for result in user! {
            if(result.active == true)
            {
                let notification = NotificationModel(id: result.id, departamento: result.department, title: result.title, message: result.message)
                self.info.append(notification)
            }
        }
        self.tblInfo.reloadData()
    }
    
    
    //check if firebase ID is in core data
    func checkDB(id: String) -> Bool
    {
        var check = false
        user = CoreDataHandler.filterData()
        
            for i in self.user! {
                if(i.id == id)
                {
                    check = true
                    break;
                }
            }
      
        return check
    }
    //disable notification from core data
    func disableNotification(id: String)
    {
        user = CoreDataHandler.filterData()
        for result in user! {
            if(result.id == id)
            {
                result.setValue(false, forKey: "active")
                do {
                    try context.save()
                }
                catch{
                    print("Error")
                }
                break
            }
        }
    }
    
    func newTopic(topic: String){
        refInfo = Database.database().reference().child("Notification").child(topic)
        refInfo.observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0{
                for message in snapshot.children.allObjects as![DataSnapshot]
                {
                    let infoObject = message.value as? [String: AnyObject]
                    let messageId = message.key
                    let messageDepartamento = infoObject?["DEPARTAMENTO"]
                    let messageTitle = infoObject?["TITULO"]
                    let messageBody = infoObject?["MENSAJE"]
                    
                    if((self.checkDB(id: (messageId as String?)!) == false))
                    {
                        CoreDataHandler.saveObject(id: (messageId as String?)!, department: (messageDepartamento as! String?)!, title: (messageTitle as! String?)!, message: (messageBody as! String?)!, active: false)
                    }
                }
            }
        }) { (error) in
            print(error)
        }
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //delete selected row from view and disable notifiacation from core data
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            
            let id = info[indexPath.row].id
            disableNotification(id: id!)
            
            
            info.remove(at: indexPath.row)
            tblInfo.reloadData()
        }
    }
    
    
 
    
}
