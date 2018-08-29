//
//  NotificationModel.swift
//  Pregunta Lobo
//
//  Created by CAM UPRA on 4/9/18.
//  Copyright © 2018 Cheylianie Rivera. All rights reserved.
//

import Foundation


class NotificationModel{
    
    
    
    var id: String?
    var departamento: String?
    var title: String?
    var message: String?
    
    init(id: String?, departamento: String?, title:String?, message: String?){
        self.id = id
        self.departamento = departamento
        self.title = title
        self.message = message
    }

}
