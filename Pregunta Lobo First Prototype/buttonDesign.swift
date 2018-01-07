//
//  File.swift
//  Pregunta Lobo
//
//  Created by Erick Rivera on 1/6/18.
//  Copyright © 2018 CAM. All rights reserved.
//

import Foundation
import UIKit

class buttonDesign: UIButton {
    
    override func didMoveToWindow() {
        
        self.backgroundColor = UIColor.gray
        self.layer.cornerRadius = 6
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    
    
    
    
    
    
    
    
    
    
    
} // class
