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
    
    
    var categoriaEscogida = String()
    var abreviacionEscogida = String()
    
    var infoView = TablaAsociaciones()
    var sendedInfo = InfoModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = abreviacionEscogida
        infoView = sendedInfo.getInfoFromDatabase(categoriaEscogida, abreviacion: abreviacionEscogida)
        setInfoToView()
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
