//
//  WriteToTextFIle.swift
//  Pregunta Lobo First Prototype
//
//  Created by Amaury Rodriguez on 11/27/15.
//  Copyright © 2015 Cheylianie Rivera. All rights reserved.
//

import Foundation

class WriteToTextFile: NSObject {
    
    var fileName = String()
    
    
    init(fileNameEntered: String)
    {
        super.init()
        fileName = fileNameEntered
    }
    
    
    //Escribir a un archivo, se envia el nombre del archivo y el string a escribir.
    func writeToFile(_ header: String, stringToFile: String)
    {
        let dir : NSString = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first! as NSString
        let path = dir.appendingPathComponent(fileName)
        
        if let outputStream = OutputStream(toFileAtPath: path, append: true)
        {
            if fileIsEmpty() == true
            {
                outputStream.open()
                let text = header + "\n" + stringToFile
                outputStream.write(text, maxLength: text.characters.count)
                outputStream.close()
            }
            else {
                outputStream.open()
                let text = stringToFile
                outputStream.write(text, maxLength: text.characters.count)
                outputStream.close()
            }
            
        }
        else {
            print("Error Writing File")
        }
    }
    
    //Leer archivo
    func readFile() -> String
    {
        let dir : NSString = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first! as NSString
        let path = dir.appendingPathComponent(fileName)
        var text2 = NSString()
        
        //reading
        do {
            text2 = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
        }
        catch {
            print("Error reading file.")
        }
        
        return text2 as String
    }
    
    
    //Verificar si el archivo esta vacio verificando la cantidad de caracteres.
    func fileIsEmpty() -> Bool
    {
        let dir : NSString = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first! as NSString
        let path = dir.appendingPathComponent(fileName)
        var text2 = NSString()
        
        //reading
        do {
            text2 = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
        }
        catch {
            print("Error reading file.")
        }
        
        if text2.length == 0 {
            return true
        }
        else {
            return false
        }
    }
    
    
    //Borrar el contenido de un archivo, se envia el nombre del archivo y el string a escribir.
    func ereaseFile()
    {
        let dir : NSString = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first! as NSString
        let path = dir.appendingPathComponent(fileName)
        
        let text = ""
        
        do
        {
            try text.write(toFile: path, atomically: false, encoding: String.Encoding.utf8)
        }
        catch
        {
            print("Error erasing file.")
        }
    }
    
    //Copiar el archivo a otro.
    func copyFile(_ destinationFile: String)
    {
        let copiedText = readFile()
        
        let dir : NSString = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first! as NSString
        let path = dir.appendingPathComponent(destinationFile)
        
        if let outputStream = OutputStream(toFileAtPath: path, append: true)
        {
            outputStream.open()
            outputStream.write(copiedText, maxLength: copiedText.characters.count)
            outputStream.close()
        }
        
    }
    
    
}
