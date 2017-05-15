//
//  MapInfoViewController.swift
//  Pregunta Lobo First Prototype
//
//  Created by CAM UPRA on 11/18/15.
//  Copyright © 2015 Cheylianie Rivera. All rights reserved.
//

import UIKit

class MapInfoViewController: UIViewController {
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
    }
    
    @IBOutlet weak var LocationImage: UIImageView!
    @IBOutlet weak var LocationImage2: UIImageView!
    @IBOutlet weak var LocationImage3: UIImageView!
    
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var infoTextView2: UITextView!
    @IBOutlet weak var infoTextView3: UITextView!
    
    @IBOutlet weak var ScrollView: UIScrollView!
    var placeInfo = String()
    var floor = String()
    var floor2 = String()
    var navigationTitle = String()
    var placeFoto = String()
    var placeFoto2 = String()
    var placeFoto3 = String()
  
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        infoTextView.isSelectable = true
        infoTextView.isEditable = false
      

        infoTextView.dataDetectorTypes = UIDataDetectorTypes.link
        
        ScrollView.isScrollEnabled = false
        LocationImage2.isHidden = true
        infoTextView2.isHidden = true
        infoTextView.isScrollEnabled = false
        infoTextView2.isScrollEnabled = false
        infoTextView3.isScrollEnabled = false
       
                            LocationImage2.isHidden = false
        
                infoTextView2.isHidden = false
            infoTextView.font = UIFont.systemFont(ofSize: 16)
            infoTextView2.font = UIFont.systemFont(ofSize: 16)
            infoTextView3.font = UIFont.systemFont(ofSize: 16)
                if DeviceType.IPHONE_5
                {
                   if(navigationTitle  == "Ala Central")
                    {
                        ScrollView.isScrollEnabled = true
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 98.0))
                
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView2, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 170.0))
                
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView3, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 95.0))
                
                        self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 495.0))
                
                    }
                    if(navigationTitle  == "Ala Oeste")
                    {
                        ScrollView.isScrollEnabled = true
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 98.0))
                
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView2, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 170.0))
                
               
                    }
                    if(navigationTitle  == "Ala Sur")
                    {
                        ScrollView.isScrollEnabled = true
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 95.0))
                
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView2, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 98.0))
                
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView3, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 75.0))
                
                        self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 495.0))

                    }
                    if(navigationTitle  == "Servicios Médicos")
                    {
                        ScrollView.isScrollEnabled = true
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 670.0))
                
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView2, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 0))
                
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView3, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 0))
                
                        self.view.addConstraint(NSLayoutConstraint(item: LocationImage2, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 0))
                
                        self.view.addConstraint(NSLayoutConstraint(item: LocationImage3, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 0))
                
                        self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 750.0))
                    }
                    if (navigationTitle == "Edificio Principal")
                    {
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 290.0))
                
                        self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 1250.0))
                        infoTextView2.isHidden = true
                
                    }
                    if navigationTitle == "Biblioteca"
                    {
                        ScrollView.isScrollEnabled = true
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 400.0))
                    }
                    if navigationTitle == "Edificio de Enfermería"
                    {
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 300.0))
                        self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 1500.0))
                    }
            }
            
                if DeviceType.IPHONE_6
                {
                    
                    if(navigationTitle  == "Ala Norte")
                    {
                        ScrollView.isScrollEnabled = true
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 85.0))
                        
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView2, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 90.0))
                        
                        self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 1090.0))
                        
                    }

                    if(navigationTitle  == "Ala Central")
                    {
                        ScrollView.isScrollEnabled = true
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 110.0))
                        
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView2, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200.0))
                        
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView3, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 110.0))
                        
                        self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 600.0))
                        
                    }
                    if(navigationTitle  == "Ala Este")
                    {
                        ScrollView.isScrollEnabled = true
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 170.0))
                        
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView2, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 90.0))
                        
                        self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 850.0))
                    }

                    if(navigationTitle  == "Ala Oeste")
                    {
                        ScrollView.isScrollEnabled = true
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 98.0))
                        
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView2, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 170.0))
                        
                        self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 1150.0))
                        
                        
                    }
                    if(navigationTitle  == "Ala Sur")
                    {
                        ScrollView.isScrollEnabled = true
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 105.0))
                        
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView2, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 140.0))
                        
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView3, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0))
                        
                        self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 600.0))
                        
                    }
                    if(navigationTitle  == "Servicios Médicos")
                    {
                        ScrollView.isScrollEnabled = true
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 800.0))
                        
                        
                        self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 1590.0))
                    }
                    if (navigationTitle == "Edificio Principal")
                    {
                        ScrollView.isScrollEnabled = true
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 240.0))
                        
                        self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 1330.0))
                        infoTextView2.isHidden = true
                        
                    }
                    if navigationTitle == "Biblioteca"
                    {
                        ScrollView.isScrollEnabled = true
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 400.0))
                    }
                    if navigationTitle == "Edificio de Enfermería"
                    {
                        ScrollView.isScrollEnabled = true
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 300.0))
                        self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 1700.0))
                    }
                    if navigationTitle == "Plaza de Fundadores"
                    {
                        ScrollView.isScrollEnabled = true
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 130.0))
                        self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 1310.0))
                        infoTextView2.isHidden = true

                    }
                    if navigationTitle == "CDATA"
                    {
                        ScrollView.isScrollEnabled = true
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 245.0))
                        self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 1320.0))
                        infoTextView2.isHidden = true
                        
                    }
                    if( navigationTitle == "Cancha de Baloncesto" )
                    {
                        ScrollView.isScrollEnabled = true
                        
                        LocationImage2.isHidden = false
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 98.0))
                        self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 1320.0))
                        infoTextView2.isHidden = true
                        
                        
                    }


                }
        if DeviceType.IPHONE_6P
        {
            if(navigationTitle  == "Ala Norte")
            {
                ScrollView.isScrollEnabled = true

                self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 85.0))
                
                self.view.addConstraint(NSLayoutConstraint(item: infoTextView2, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 90.0))
                
                self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 1090.0))
                
                ScrollView.isScrollEnabled = false
            }
            
            if(navigationTitle  == "Ala Central")
            {
                ScrollView.isScrollEnabled = true

                self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 110.0))
                
                self.view.addConstraint(NSLayoutConstraint(item: infoTextView2, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200.0))
                
                self.view.addConstraint(NSLayoutConstraint(item: infoTextView3, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 110.0))
                
                self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 600.0))
                
            }
            if(navigationTitle  == "Ala Este")
            {
                self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 170.0))
                
                self.view.addConstraint(NSLayoutConstraint(item: infoTextView2, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 90.0))
                
                self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 900.0))
            }
            
            if(navigationTitle  == "Ala Oeste")
            {
                ScrollView.isScrollEnabled = true

                self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 98.0))
                
                self.view.addConstraint(NSLayoutConstraint(item: infoTextView2, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 170.0))
                
                self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 1240.0))
                
                
            }
            if(navigationTitle  == "Ala Sur")
            {
                ScrollView.isScrollEnabled = true

                self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 105.0))
                
                self.view.addConstraint(NSLayoutConstraint(item: infoTextView2, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 140.0))
                
                self.view.addConstraint(NSLayoutConstraint(item: infoTextView3, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0))
                
                self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 650.0))
                
            }
            if(navigationTitle  == "Servicios Médicos")
            {
                ScrollView.isScrollEnabled = true

                self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 800.0))
                
                
                self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 1650.0))
            }
            if (navigationTitle == "Edificio Principal")
            {
                ScrollView.isScrollEnabled = true

                self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 240.0))
                
                self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 1400.0))
                infoTextView2.isHidden = true
                
            }
            if navigationTitle == "Biblioteca"
            {
                ScrollView.isScrollEnabled = true

                self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 400.0))
                self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 634.0))
            }
            if navigationTitle == "Edificio de Enfermería"
            {
                ScrollView.isScrollEnabled = true

                self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 300.0))
                self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 1700.0))
            }
            if navigationTitle == "Plaza de Fundadores"
            {
                self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 130.0))
                self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 1310.0))
                infoTextView2.isHidden = true
                
                ScrollView.isScrollEnabled = false
                
            }
            if navigationTitle == "CDATA"
            {
                self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 245.0))
                self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 1370.0))
                infoTextView2.isHidden = true
                
            }
            if( navigationTitle == "Cancha de Baloncesto" )
            {
                
                LocationImage2.isHidden = false
                self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 98.0))
                self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 1320.0))
                infoTextView2.isHidden = true
                
                ScrollView.isScrollEnabled = false
                
                
            }
        }

        
            
            else
                {
            self.view.addConstraint(NSLayoutConstraint(item: LocationImage, attribute: .height, relatedBy: .equal,
            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 300.0))
            self.view.addConstraint(NSLayoutConstraint(item: LocationImage2, attribute: .height, relatedBy: .equal,
            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 300.0))
            self.view.addConstraint(NSLayoutConstraint(item: LocationImage3, attribute: .height, relatedBy: .equal,
            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 300.0))
            ScrollView.isScrollEnabled=false
            infoTextView2.isHidden = true
            infoTextView3.isHidden = true
            LocationImage2.isHidden = true
            LocationImage3.isHidden = true
            infoTextView.font = UIFont.systemFont(ofSize: 20)
            infoTextView2.font = UIFont.systemFont(ofSize: 20)
            infoTextView3.font = UIFont.systemFont(ofSize: 20)
            
            
                    
            if navigationTitle == "Biblioteca"
            {
                ScrollView.isScrollEnabled = true
                infoTextView2.isHidden = false
                LocationImage2.isHidden = false
                infoTextView3.isHidden = false
                LocationImage3.isHidden = false
                self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 450.0))
                self.view.addConstraint(NSLayoutConstraint(item: infoTextView2, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 250.0))
                
                self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 900))
                
            }
                    
            if navigationTitle == "Servicios Médicos"
            {
                ScrollView.isScrollEnabled = true
                self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 900.0))
                self.view.addConstraint(NSLayoutConstraint(item: infoTextView2, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0))
                self.view.addConstraint(NSLayoutConstraint(item: infoTextView3, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0))
                self.view.addConstraint(NSLayoutConstraint(item: LocationImage2, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0))
                self.view.addConstraint(NSLayoutConstraint(item: LocationImage3, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0))
                
            }
            if navigationTitle == "Edificio Principal"
            {
                ScrollView.isScrollEnabled = true
                self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 380.0))
                 LocationImage2.isHidden = false
                self.view.addConstraint(NSLayoutConstraint(item: infoTextView3, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0))
               
                self.view.addConstraint(NSLayoutConstraint(item: LocationImage3, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0))
                self.view.addConstraint(NSLayoutConstraint(item: infoTextView2, attribute: .height, relatedBy: .equal,
                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0))
                
                    }
                    if navigationTitle == "Edificio de Enfermería"
                    {
                        ScrollView.isScrollEnabled = false
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 500.0))
                        
                    }
                    if( navigationTitle == "Cancha de Baloncesto" )
                    {
                        
                        LocationImage2.isHidden = false
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0))
                        
                        
                        
                    }
                    if navigationTitle == "Ala Sur"
                    {
                        ScrollView.isScrollEnabled = true
                        infoTextView2.isHidden = false
                        LocationImage2.isHidden = false
                        infoTextView3.isHidden = false
                        LocationImage3.isHidden = false
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150.0))
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView2, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200.0))
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView3, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200.0))
                        self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 900))
                        
                    }
                    if navigationTitle == "Ala Este"
                    {
                        ScrollView.isScrollEnabled = true
                        infoTextView2.isHidden = false
                        LocationImage2.isHidden = false
                        infoTextView3.isHidden = false
                        LocationImage3.isHidden = false
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200.0))
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView2, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0))
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView3, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0))
                        self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 900))
                        
                    }
                    if navigationTitle == "Ala Norte"
                    {
                        infoTextView2.isHidden = false
                        LocationImage2.isHidden = false
                       
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150.0))
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView2, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150.0))
                      
                        
                    }
                    if navigationTitle == "Ala Oeste"
                    {
                        infoTextView2.isHidden = false
                        LocationImage2.isHidden = false
                        
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150.0))
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView2, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150.0))
                        
                    }
                    if navigationTitle == "Ala Central"
                    {
                        ScrollView.isScrollEnabled = true
                        infoTextView2.isHidden = false
                        LocationImage2.isHidden = false
                        infoTextView3.isHidden = false
                        LocationImage3.isHidden = false
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150.0))
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView2, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0))
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView3, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150))
                        self.view.addConstraint(NSLayoutConstraint(item: ScrollView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 900))
                        
                    }
                    if navigationTitle == "Plaza de Fundadores"
                    {
                        
                        
                        LocationImage2.isHidden = false
                       
                        self.view.addConstraint(NSLayoutConstraint(item: infoTextView, attribute: .height, relatedBy: .equal,
                            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150.0))
                        
                        
                    }






                    
            
        }
        
        
        infoTextView.text = placeInfo
        infoTextView2.text = floor
        infoTextView3.text = floor2
        navigationItem.title = navigationTitle
        let image = UIImage(named: placeFoto)
        let image2 = UIImage(named: placeFoto2)
        let image3 = UIImage(named: placeFoto3)
        LocationImage.image = image
        LocationImage2.image = image2
        LocationImage3.image = image3
        
       
        
                // Do any additional setup after loading the view.
        }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
