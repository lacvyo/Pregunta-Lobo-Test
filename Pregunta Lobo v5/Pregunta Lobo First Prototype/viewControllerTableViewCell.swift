//
//  viewControllerTableViewCell.swift
//  Pregunta Lobo
//
//  Created by CAM UPRA on 4/9/18.
//  Copyright © 2018 Cheylianie Rivera. All rights reserved.
//

import UIKit

class viewControllerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblDepartamento: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
