//
//  AbreviacionModel.swift
//  Pregunta Lobo First Prototype
//
//  Created by Amaury Rodriguez on 11/2/15.
//  Copyright © 2015 Cheylianie Rivera. All rights reserved.
//

import UIKit

class AbreviacionModel: NSObject {
    
    var asociacionesDatabase: FMDatabase? = nil
    
    func getAbreviacionesFromDataBase(_ tableName: String) -> [String] {
        
        asocSharedInstance.asociacionesDatabase!.open()
        
        var abreviaciones = [String]()
        let resultSet: FMResultSet! = asocSharedInstance.asociacionesDatabase!.executeQuery("SELECT abreviacion FROM \(tableName) ORDER BY abreviacion COLLATE NOCASE ASC", withArgumentsIn: nil)
        
        if resultSet != nil {
            while resultSet.next() {
                abreviaciones.append(resultSet.string(forColumn: "abreviacion"))
            }
        }
        
        asocSharedInstance.asociacionesDatabase!.close()
        return abreviaciones
        
    }
    
}
