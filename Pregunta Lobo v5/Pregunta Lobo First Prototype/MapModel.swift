//
//  MapModel.swift
//  Pregunta Lobo First Prototype
//
//  Created by CAM UPRA on 11/18/15.
//  Copyright © 2015 Cheylianie Rivera. All rights reserved.
//

import UIKit

//let MapSharedInstance = MapModel()

class MapModel: NSObject {
    var mapDatabase: FMDatabase? = nil
    var util = Utility()
    
    /*func getInstance() -> MapModel {
        if(MapSharedInstance.mapDatabase == nil) {
            MapSharedInstance.mapDatabase = FMDatabase(path: util.getPath("Map.db"))
        }
        
        return MapSharedInstance
    }*/
    
    
    func getPlacesFromDatabase() -> [String] {
        
        MapSharedInstance.mapDatabase!.open()
        
        var place = [String]()
        let resultSet: FMResultSet! = MapSharedInstance.mapDatabase!.executeQuery("SELECT name FROM sqlite_master WHERE type ='table'", withArgumentsIn: nil)
        
        if resultSet != nil {
            while resultSet.next() {
                place.append(resultSet.string(forColumn: "place"))
            }
        }
        
        MapSharedInstance.mapDatabase!.close()
        return place
    }


}
