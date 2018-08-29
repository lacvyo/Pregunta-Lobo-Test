//
//  MapInfoModel.swift
//  Pregunta Lobo First Prototype
//
//  Created by CAM UPRA on 11/18/15.
//  Copyright © 2015 Cheylianie Rivera. All rights reserved.
//


import UIKit

let MapSharedInstance = MapInfoModel()

class MapInfoModel: NSObject {
    
    var mapDatabase: FMDatabase? = nil
    var util = Utility()
    
    func getInstance() -> MapInfoModel {
        if(MapSharedInstance.mapDatabase == nil) {
            MapSharedInstance.mapDatabase = FMDatabase(path: util.getPath("Map.db"))
        }
        
        return MapSharedInstance
    }
    
    func getInfoFromDatabase(_ place: String) -> TablaMapa {
        
        MapSharedInstance.mapDatabase!.open()
        
        let tablaDeMapa = TablaMapa()
        let nilCell = "No disponible"
        
        let resultSet: FMResultSet! = MapSharedInstance.mapDatabase!.executeQuery("SELECT * FROM annotation_info WHERE place = ?", withArgumentsIn: [place])
        
        if resultSet != nil {
            resultSet.next()
            
            if resultSet.string(forColumn: "id") != nil {
                tablaDeMapa.id = resultSet.string(forColumn: "id")
            } else {
                tablaDeMapa.id = nilCell
            }
            
            if resultSet.string(forColumn: "place") != nil {
                tablaDeMapa.places = resultSet.string(forColumn: "place")
            } else {
                tablaDeMapa.places = nilCell
            }
            
            if resultSet.string(forColumn: "image_1") != nil {
                tablaDeMapa.image1 = resultSet.string(forColumn: "image_1")
            } else {
                tablaDeMapa.image1 = nilCell
            }
            
            if resultSet.string(forColumn: "image_2") != nil {
                tablaDeMapa.image2 = resultSet.string(forColumn: "image_2")
            } else {
                tablaDeMapa.image2 = nilCell
            }
            
            if resultSet.string(forColumn: "image_3") != nil {
                tablaDeMapa.image3 = resultSet.string(forColumn: "image_3")
            } else {
                tablaDeMapa.image3 = nilCell
            }
            
            if resultSet.string(forColumn: "info") != nil {
                tablaDeMapa.info = resultSet.string(forColumn: "info")
            } else {
                tablaDeMapa.info = nilCell
            }
            
            if resultSet.string(forColumn: "floor_1") != nil {
                tablaDeMapa.floor1 = resultSet.string(forColumn: "floor_1")
            } else {
                tablaDeMapa.floor1 = nilCell
            }
            
            if resultSet.string(forColumn: "floor_2") != nil {
                tablaDeMapa.floor2 = resultSet.string(forColumn: "floor_2")
            } else {
                tablaDeMapa.floor2 = nilCell
            }
            
            if resultSet.string(forColumn: "floor_3") != nil {
                tablaDeMapa.floor3 = resultSet.string(forColumn: "floor_3")
            } else {
                tablaDeMapa.floor3 = nilCell
            }
            
           
            
        }
        
        MapSharedInstance.mapDatabase!.close()
        return tablaDeMapa
        
    }
    
}
