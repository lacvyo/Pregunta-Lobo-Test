//
//  InfoViewController.swift
//  Pregunta Lobo First Prototype
//
//  Created by Amaury Rodriguez on 10/29/15.
//  Copyright © 2015 Cheylianie Rivera. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var consejeroLabel: UILabel!
    @IBOutlet weak var departamentoLabel: UILabel!
    @IBOutlet weak var informacionLabel: UILabel!
    
    @IBOutlet weak var logoImage: UIImageView!
    
    
    struct ScreenSize
    {
        static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct DeviceType
    {
        static let IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static var IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    }
    
    
    
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var categoriaEscogida = String()
    var abreviacionEscogida = String()
    
    @IBOutlet weak var info: UILabel!
    
    var infoView = TablaAsociaciones()
    var sendedInfo = InfoModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = abreviacionEscogida
        infoView = sendedInfo.getInfoFromDatabase(categoriaEscogida, abreviacion: abreviacionEscogida)
        setInfoToView()
        
        if (DeviceType.IPHONE_6)
        {
            self.imageWidth.constant = 115
        }
        else if (DeviceType.IPHONE_5)
        {
            self.topConstraint.constant = 15
            self.imageWidth.constant = 70
            self.bottomConstraint.constant = 55
            
            self.view.addConstraint(NSLayoutConstraint(item: info, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 275.0))
            // self.view.addConstraint(NSLayoutConstraint(item: info, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 105.0))
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setInfoToView() {
        
        let image = UIImage(named: infoView.logo)
        
        nombreLabel.text = infoView.nombre
        consejeroLabel.text = infoView.consejero
        departamentoLabel.text = infoView.departamento
        informacionLabel.text = infoView.informacion
        
        logoImage.image = image
        
    }
    
    
//    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
//        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
//            //print("landscape")
//            logoImage.hidden = true;
//            
//    
//            
//        } else {
//            //print("portrait")
//            logoImage.hidden = false;
//        }
//    }

    
}
