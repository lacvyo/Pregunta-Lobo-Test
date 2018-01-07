//
//  DetailsViewController.swift
//  Pregunta Lobo
//
//  Created by Erick on 8/31/17.
//  Copyright © 2017 UPRA. All rights reserved.
//

import UIKit
import EventKit

class detailsViewController: UIViewController {
    
    @IBOutlet weak var addCalendarButton: buttonDesign!
    
    
    var getname = String()
    var getdescription = String()
    var getSdate = String()
    var getFdate = String()
    var getSavedBool = Bool()
    
    var startDate = Date()
    var finishDate = Date()
    
    var presentSdate = String()
    var presentFdate = String()
    
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelFdate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        labelName.text! = getname
        labelDescription.text! = getdescription
        
        startDate = formatDateGet(when: getSdate)
        finishDate = formatDateGet(when: getFdate)
        presentFdate = presentingDate(dateGet: finishDate)
        presentSdate = presentingDate(dateGet: startDate)
        
        labelFdate.text! = presentFdate
        labelDate.text! = presentSdate
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func passingToPopup(_ sender: Any) {
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let PvC = Storyboard.instantiateViewController(withIdentifier: "addToCalendarViewController") as! addToCalendarViewController
            
            PvC.getnamePopup = getname
            PvC.getdescriptionPopup = getdescription
            PvC.getStartDate = startDate
            PvC.getDoneDate = finishDate
            
            PvC.modalTransitionStyle = .crossDissolve
            present(PvC,animated: true, completion: nil)
        }
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone) {
            let Storyboard = UIStoryboard(name: "iPod", bundle: nil)
            let PvC = Storyboard.instantiateViewController(withIdentifier: "addToCalendarViewController") as! addToCalendarViewController
            
            PvC.getnamePopup = getname
            PvC.getdescriptionPopup = getdescription
            PvC.getStartDate = startDate
            PvC.getDoneDate = finishDate
            
            PvC.modalTransitionStyle = .crossDissolve
            present(PvC,animated: true, completion: nil)
        }
    }
    
    
    
    
} // class

