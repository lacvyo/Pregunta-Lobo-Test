//
//  CalendarioViewController.swift
//  Pregunta Lobo
//
//  Created by Erick on 8/31/17.
//  Copyright © 2017 UPRA. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging
import FirebaseDatabase



class CalerdarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref: DatabaseReference? // Var to reference the database on FIR.
    
    var refHandle: DatabaseHandle? // Handler to watch changes on database.
    var eventList = [Events]() // Array who will present the data on table view.
    
    let date = Date()
    var userEntered = 0
    let calendarFile = WriteToTextFile(fileNameEntered: "Calendar.txt")
    var stringSendedToFile = ""

    @IBOutlet weak var tableView: UITableView! // Asigns table view to the view controller.
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.startAnimating()
        
        // referencing to db
        ref = Database.database().reference()
        
        
        fetchEvents() // Initialize the table view with the data on firebase
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Function to keep track of any changes will the user is in the view.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // For purpose of feedback to know how many times the user access the calendar tab.
        userEntered = userEntered + 1
    
        
        stringSendedToFile = "TheDelimeter\n\(date)\n" + String(userEntered)
        
        calendarFile.writeToFile("***************Feedback De Calendario****************", stringToFile:  stringSendedToFile  + "\n")
        fetchChanges() // Retrieves any changes made to any event and updates the row of it.
        fetchRemoved() // Verify if an event is removed and removes it from table view.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            
            let connectedRef = Database.database().reference(withPath: ".info/connected") // Conection to know if the device is connected to the service.
            connectedRef.observe(.value, with: { snapshot in
                if snapshot.value as? Bool ?? false {
                    print("Connected")
                } else {
                    print("Not connected")
                    self.spinner.stopAnimating()
                    self.spinner.isHidden = true
                    let alert = UIAlertController(title: "No Hay Conexión", message: "Asegurece de conectar su dispostivo al internet y vuelva a intentarlo.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                        NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            })
            
        })
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return eventList.count
    }
    
    // MARK: - Funtion where the table view cell is populated. Here the data is asigned to the custom table view cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! customTableViewCell // Cells are asigned to use custom layout.
        
        let event = eventList[indexPath.row]
        cell.titleLabel?.text = event.titulo
        cell.descriptionLabel?.text = event.descripcion
        
        // if statements made to validate that the dates are not null else, present TBA.
        if(event.efecha == nil){
            cell.sDateLabel?.text = "TBA"
        }else{
            cell.sDateLabel?.text = changingPresentingDate(fechaGet: event.efecha!)
        }
        
        if(event.tfecha == nil){
            cell.fDateLabel?.text = "TBA"
        }else{
            cell.fDateLabel?.text = changingPresentingDate(fechaGet: event.tfecha!)
        }
        cell.selectionStyle = .none
        
        return cell
    }
    
    // MARK: - Function to get the data of the selected cell to be presented on the details view controller.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone) {
            
            let Storyboard = UIStoryboard(name: "iPod", bundle: nil)
            
            let DvC = Storyboard.instantiateViewController(withIdentifier: "detailsViewController") as! detailsViewController // Creating an instance of the Details view controller.
            let event = eventList[indexPath.row] // Points to the data of the selected cell.
            
            // Assing values to the Details view controller instance.
            DvC.getname = event.titulo!
            DvC.getdescription = event.descripcion!
            DvC.getSdate = event.efecha!
            DvC.getFdate = event.tfecha!
            
            
            self.ref?.removeObserver(withHandle: refHandle!)// removing reference handler to prevent too many use of memory.
            self.navigationController?.pushViewController(DvC, animated: true) // Transition to the details view controller.
        }
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let DvC = Storyboard.instantiateViewController(withIdentifier: "detailsViewController") as! detailsViewController // Creating an instance of the Details view controller.
            let event = eventList[indexPath.row] // Points to the data of the selected cell.
            
            // Assing values to the Details view controller instance.
            DvC.getname = event.titulo!
            DvC.getdescription = event.descripcion!
            DvC.getSdate = event.efecha!
            DvC.getFdate = event.tfecha!
            
            
            self.ref?.removeObserver(withHandle: refHandle!)// removing reference handler to prevent too many use of memory.
            self.navigationController?.pushViewController(DvC, animated: true) // Transition to the details view controller.
        }
        
        
    }
    
    // MARK: - Function to fecth the events on database and present them on table view.
    func fetchEvents() {
        
        refHandle = ref?.child("Eventos").observe(.childAdded, with: { (snapshot) in // Referencing to the child "Eventos" of the db and observing of any event added.
            
            if let dictionary = snapshot.value as? [String : AnyObject] { // Verify if there is any dictionary with the correct keys.
                
                let event = Events() // creating an object of the Events Class
                
                event.setValuesForKeys(dictionary) // Setting values to keys.
                
                self.eventList.append(event) // Inserting values of the object to the array presented on table view.
                
                DispatchQueue.main.async {
                    self.tableView.reloadData() // Reloads the data in the table view.
                    self.spinner.stopAnimating()
                    self.spinner.isHidden = true
                }
                
            }
        })
        
        
    }
    
    // MARK: - Function to fetch any changes made on events and presenting it in the table view row of it.
    func fetchChanges() -> Void {
        
        refHandle = ref?.child("Eventos").observe(DataEventType.childChanged, with: {(snapshot) in // Observing for any changes on childs of the child Eventos.
            let eventDict = snapshot.value as? [String: Any] ?? [:] // Dictionary of the child modificated.
            //  let eventKey = snapshot.key
            let tempEID = eventDict["eID"] as! String // ID of the modified event. Casting it to be string
            
            if let index = self.eventList.index(where: {$0.eID == tempEID}) { // Verifying that the row event ID to be update is equal to the event ID modified.
                print("found it!", index)
                
                // Updating values for keys..
                self.eventList[index].titulo = (eventDict["titulo"] as! String)
                self.eventList[index].descripcion  = (eventDict["descripcion"] as! String)
                self.eventList[index].efecha = (eventDict["efecha"] as! String)
                self.eventList[index].tfecha = (eventDict["tfecha"] as! String)
                
                // Updating the specific row of the event.
                let indexPath = IndexPath(item: index, section: 0)
                self.tableView.reloadRows(at: [indexPath], with: .top)
                
            } else {
                print("Not working... :(")
            }
            
            //print(tempEID)
            
        })
        
    }
    
    // MARK: - Function to fetch removed events and remove it from the table view.
    func fetchRemoved() -> Void {
        refHandle = ref?.child("Eventos").observe(DataEventType.childRemoved, with: {(snapshot) in // Observing for removed childs of the child Eventos.
            let eventDict = snapshot.value as? [String: Any] ?? [:] // Dictionary of the child removed.
            //  let eventKey = snapshot.key
            let tempEID = eventDict["eID"] as! String // ID of the removed event. Casting it to be string
            
            if let index = self.eventList.index(where: {$0.eID == tempEID}) { // Verifying that the row event ID to be remove is equal to the event ID removed.
                print("found it!", index)
                self.eventList.remove(at: index) // Removing the event from the array of events presented on table view.
                self.tableView.reloadData() // Reloading the data on table view.
            } else {
                print("Not working... :(")
            }
            
            
        })
        
    }
    
  
    
    
    
} // class

extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
} // extension
