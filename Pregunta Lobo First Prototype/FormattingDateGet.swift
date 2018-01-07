//
//  FormattingDateGet.swift
//  Pregunta Lobo
//
//  Created by Erick on 11/10/17.
//  Copyright © 2017 UPRA. All rights reserved.
//

import Foundation
import UIKit

func formatDateGet (when: String) -> Date {
    
    var whenDate: Date?
    
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss" // Si se quiere presentar la hora también el formato es: "yyyy-MM-dd HH:mm:ss"
    
    whenDate = dateFormatterGet.date(from: when)
    
    return whenDate!
}

func presentingDate(dateGet: Date) -> String {
    
    var datePresenting: String?
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, yyyy" // Si se quiere presentar la hora también el formato es: "MMM d, h:mm a"
    
    datePresenting = dateFormatter.string(from: dateGet)
    
    
    return datePresenting!
}

func changingPresentingDate(fechaGet: String) -> String {
    
    var datePresenting: String?
    var fechaTypeDate: Date?
    
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, yyyy"
    
    fechaTypeDate = dateFormatterGet.date(from: fechaGet)
    
    datePresenting = dateFormatter.string(from: fechaTypeDate!)
    
    
    return datePresenting!
}

