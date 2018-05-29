//
//  QuestionModel.swift
//  Pregunta Lobo First Prototype
//
//  Created by Amaury Rodriguez on 10/20/15.
//  Copyright © 2015 Cheylianie Rivera. All rights reserved.
//

import UIKit

let sharedInstance = QuestionModel()

class QuestionModel: NSObject {
    
    var database: FMDatabase? = nil
    var util = Utility()
    let databaseAnswers = Answers()
    
    //Optener el path de la base de datos.
    func getInstance() -> QuestionModel {
        if(sharedInstance.database == nil) {
            sharedInstance.database = FMDatabase(path: util.getPath("testdb.db"))
        }
        
        return sharedInstance
    }
    
    
    func checkKeywords(_ question: String) -> Answers {
        
        sharedInstance.database!.open()
        
        //Obtener la tabla completa de keywords y concepts.
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM keywords", withArgumentsIn: nil)
        var conceptsResultSet: FMResultSet!
        
        let databaseKeywords = Keywords()
        let userKeywords = List()
        let conceptsKeywords = Concepts()
        var questionArray = question.components(separatedBy: " ")
        var conceptFound = false
        var conceptCount = 0
        
        for i in 0 ..< questionArray.count {
            userKeywords.insertIntoList(questionArray[i])
    
            
        }
        
        if (resultSet != nil) {
            while resultSet.next() {
                
                for i in (0..<(resultSet.columnCount() - 3)) {
                    if resultSet.string(forColumn: "keyw\(i)") != nil {
                        databaseKeywords.keywordsStack.push(resultSet.string(forColumn: "keyw\(i)"))
                    }
                }
                
                while databaseKeywords.keywordsStack.isEmpty() != true {
                    
                    if databaseKeywords.keywordsStack.lookTop().hasPrefix("_") {
                        
                        conceptsKeywords.conceptsStack.deleteAll()
                        conceptsResultSet = nil
                        
                        conceptsResultSet = sharedInstance.database!.executeQuery("SELECT * FROM concepts WHERE id = ?", withArgumentsIn: [databaseKeywords.keywordsStack.lookTop()])
                        conceptCount = conceptsResultSet.columnCount()-2
                        
                        if conceptsResultSet != nil {
                            
                            conceptsResultSet.next()
                            
                            for i in (0..<conceptCount) {
                                if conceptsResultSet.string(forColumn: "concept\(i)") != nil {
                                    conceptsKeywords.conceptsStack.push(conceptsResultSet.string(forColumn: "concept\(i)"))
                                }
                            }
                            
                            
                            while conceptsKeywords.conceptsStack.isEmpty() != true {
                                if userKeywords.isInListAndRemove(conceptsKeywords.conceptsStack.lookTop()) {
                                    conceptsKeywords.conceptsStack.deleteAll()
                                    conceptFound = true
                                    break
                                } else {
                                    conceptsKeywords.conceptsStack.pop()
                                    conceptFound = false
                                }
                            }
                            
                            
                            if conceptsKeywords.conceptsStack.isEmpty() && conceptFound {
                                databaseKeywords.keywordsStack.pop()
                            } else {
                                break
                            }
                        }
                    } else if userKeywords.isInListAndRemove(databaseKeywords.keywordsStack.lookTop()) {
                        databaseKeywords.keywordsStack.pop()
                    } else {
                        break
                    }
                }
                
                if databaseKeywords.keywordsStack.isEmpty() && resultSet.string(forColumn: "_id") != nil {
                    //Obtener el id de la respuesta para enviarlo.
                    databaseKeywords.id = resultSet.string(forColumn: "_id")
                    databaseKeywords.idAnswer = resultSet.string(forColumn: "id_answer")
                    
                    sharedInstance.database!.close()
                    return getAnswer(databaseKeywords)
                }
                
                databaseKeywords.keywordsStack.deleteAll()
                userKeywords.removeAll()
                for i in 0 ..< questionArray.count {
                    userKeywords.insertIntoList(questionArray[i])
                }
            }
            
        }
        
        sharedInstance.database!.close()
        databaseAnswers.answer = "No tenemos una contestación, pero evaluaremos su pregunta."
        return databaseAnswers
    }
    
    
    func getAnswer(_ checkThisId: Keywords) -> Answers {
        
        sharedInstance.database!.open()
        
        //Obtener la contestacion donde el id de answers sea igual al id de keywords.
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM answers WHERE id = ?", withArgumentsIn: [checkThisId.idAnswer])
        
        if (resultSet != nil) {
            resultSet.next()
            databaseAnswers.id = resultSet.string(forColumn: "id")
            databaseAnswers.answer = resultSet.string(forColumn: "answer")
            sharedInstance.database!.close()
        }
        
        return databaseAnswers
    }
    
}
