//
//  CategoriesModel.swift
//  Pregunta Lobo First Prototype
//
//  Created by Amaury Rodriguez on 11/1/15.
//  Copyright © 2015 Cheylianie Rivera. All rights reserved.
//

import UIKit

let asocSharedInstance = CategoriesModel()

class CategoriesModel: NSObject
{
    
    var asociacionesDatabase: FMDatabase? = nil
    var util = Utility()
    
    //Verificar si la base de datos existe.
    func getInstance() -> CategoriesModel {
        if(asocSharedInstance.asociacionesDatabase == nil) {
            asocSharedInstance.asociacionesDatabase = FMDatabase(path: util.getPath("asociacionesdb.db"))
        }
        
        return asocSharedInstance
    }
    
    func getCategoriesFromDatabase() -> [String] {
        
        asocSharedInstance.asociacionesDatabase!.open()
        
        var categories = [String]()
        let resultSet: FMResultSet! = asocSharedInstance.asociacionesDatabase!.executeQuery("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name COLLATE NOCASE ASC", withArgumentsIn: nil)
        
        if resultSet != nil {
            while resultSet.next() {
                categories.append(resultSet.string(forColumn: "name"))
            }
        }
        
        asocSharedInstance.asociacionesDatabase!.close()
        return categories
    }
    
}
