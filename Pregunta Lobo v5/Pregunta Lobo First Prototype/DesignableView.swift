//
//  DesignableView.swift
//  Pregunta Lobo
//
//  Created by Erick on 9/15/17.
//  Copyright © 2017 UPRA. All rights reserved.
//

import UIKit

@IBDesignable class DesignableView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    
    
    
} // class
