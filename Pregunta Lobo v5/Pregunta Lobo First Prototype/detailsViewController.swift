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
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelFdate: UILabel!
    
    
    @IBOutlet weak var leftBtnConstraint: NSLayoutConstraint!
    @IBOutlet weak var topBtnConstraint: NSLayoutConstraint!
    @IBOutlet weak var txtTitulo: UILabel!
    @IBOutlet weak var lblEvento: UILabel!
    
    @IBOutlet weak var lblComienzaWidthConstraint: NSLayoutConstraint!
    
  
    @IBOutlet weak var textDescription: UITextView!
    
    struct ScreenSize
    {
        static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct DeviceType
    {
        static let IPHONE_4_LESS =  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static var IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IPHONE_7 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IPHONE_X = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    }
    
   


    
    @IBOutlet weak var comienzaHeightConstraint: NSLayoutConstraint!
   
    
    @IBOutlet weak var pageConstraint: NSLayoutConstraint!
    @IBOutlet weak var comienzaRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var eventTopConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        labelName.text! = getname
//        labelDescription.text! = getdescription
        
        textDescription.text! = getdescription
        
        startDate = formatDateGet(when: getSdate)
        finishDate = formatDateGet(when: getFdate)
        presentFdate = presentingDate(dateGet: finishDate)
        presentSdate = presentingDate(dateGet: startDate)
        
        labelFdate.text! = presentFdate
        labelDate.text! = presentSdate
        
        
        if(DeviceType.IPHONE_5)
        {
            self.view.addConstraint(NSLayoutConstraint(item: addCalendarButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200.0))
            
             self.view.addConstraint(NSLayoutConstraint(item: lblEvento, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 300.0))
            
            self.view.addConstraint(NSLayoutConstraint(item: lblEvento, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 300.0))
            
            self.view.addConstraint(NSLayoutConstraint(item: addCalendarButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0))
            
            self.eventTopConstraint.constant = 20
            self.comienzaHeightConstraint.constant = 0
            self.leftBtnConstraint.constant = ScreenSize.SCREEN_WIDTH / 7
            self.topBtnConstraint.constant = 15
            self.lblComienzaWidthConstraint.constant = 20
            self.comienzaRightConstraint.constant = 30
            self.pageConstraint.constant = 16
            
        }
        
        else if(DeviceType.IPHONE_6)
        {
            
        self.view.addConstraint(NSLayoutConstraint(item: addCalendarButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200.0))
        
            
            self.comienzaHeightConstraint.constant = 0
            self.topBtnConstraint.constant = 45
            self.leftBtnConstraint.constant = ScreenSize.SCREEN_WIDTH / 5
            self.pageConstraint.constant = 18
        }
        
        else if (DeviceType.IPHONE_6P)
        {
            
            self.view.addConstraint(NSLayoutConstraint(item: addCalendarButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200.0))
         
            
            self.comienzaHeightConstraint.constant = 0
            self.topBtnConstraint.constant = 50
            self.leftBtnConstraint.constant = ScreenSize.SCREEN_WIDTH / 5
        }
        
        else if (DeviceType.IPHONE_X)
        {
            
            self.view.addConstraint(NSLayoutConstraint(item: addCalendarButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200.0))
            
            
            self.comienzaHeightConstraint.constant = 0
            self.topBtnConstraint.constant = 70
            self.leftBtnConstraint.constant = ScreenSize.SCREEN_WIDTH / 5
            
        }
        
        
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

