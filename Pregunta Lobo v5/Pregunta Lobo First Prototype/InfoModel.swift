//
//  InfoModel.swift
//  Pregunta Lobo First Prototype
//
//  Created by Amaury Rodriguez on 11/2/15.
//  Copyright © 2015 Cheylianie Rivera. All rights reserved.
//

import UIKit

class InfoModel: NSObject {
    
    var asociacionesDatabase: FMDatabase? = nil
    
    func getInfoFromDatabase(_ tableName: String, abreviacion: String) -> TablaAsociaciones {
        
        asocSharedInstance.asociacionesDatabase!.open()
        
        let tablaDeAsociaciones = TablaAsociaciones()
        let nilCell = "No disponible"
        
        let resultSet: FMResultSet! = asocSharedInstance.asociacionesDatabase!.executeQuery("SELECT * FROM \(tableName) WHERE abreviacion = ?", withArgumentsIn: [abreviacion])
        
        if resultSet != nil {
            resultSet.next()
            
            if resultSet.string(forColumn: "id") != nil {
                tablaDeAsociaciones.id = resultSet.string(forColumn: "id")
            } else {
                tablaDeAsociaciones.id = nilCell
            }
            
            if resultSet.string(forColumn: "abreviacion") != nil {
                tablaDeAsociaciones.abreviacion = resultSet.string(forColumn: "abreviacion")
            } else {
                tablaDeAsociaciones.abreviacion = nilCell
            }
            
            if resultSet.string(forColumn: "nombre") != nil {
                tablaDeAsociaciones.nombre = resultSet.string(forColumn: "nombre")
            } else {
                tablaDeAsociaciones.nombre = nilCell
            }
            
            if resultSet.string(forColumn: "logo") != nil {
                tablaDeAsociaciones.logo = resultSet.string(forColumn: "logo")
            } else {
                tablaDeAsociaciones.logo = nilCell
            }
            
            if resultSet.string(forColumn: "consejero") != nil {
                tablaDeAsociaciones.consejero = resultSet.string(forColumn: "consejero")
            } else {
                tablaDeAsociaciones.consejero = nilCell
            }
            
            if resultSet.string(forColumn: "departamento") != nil {
                tablaDeAsociaciones.departamento = resultSet.string(forColumn: "departamento")
            } else {
                tablaDeAsociaciones.departamento = nilCell
            }
            
            if resultSet.string(forColumn: "informacion") != nil {
                tablaDeAsociaciones.informacion = resultSet.string(forColumn: "informacion")
            } else {
                tablaDeAsociaciones.informacion = nilCell
            }
            
        }
        
        asocSharedInstance.asociacionesDatabase!.close()
        return tablaDeAsociaciones
        
    }
    
}
