//
//  fileHandler.swift
//  ContactViewer
//
//  Created by Edward Castillo on 4/14/15.
//  Copyright (c) 2015 seng5199-3. All rights reserved.
//

import Foundation
class FileHandler: NSObject {
    
    let file = "contacts.json"
    var textRead = ""
    
    func readFromFile () -> String {
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            let path = dir.stringByAppendingPathComponent(file);
            textRead = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)!

        } else {
            return "Unable to read from file."
        }
        return textRead
        
    }
    
    func writeToFile (dataWrite:NSData) {
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            let path = dir.stringByAppendingPathComponent(file);
      
            dataWrite.writeToFile(path, atomically: false)
            /*if let outputStream = NSOutputStream(toFileAtPath: path, append: true) {
                outputStream.open()
                let text = "Hello World"
                outputStream.write(text, maxLength: 20000)
                
            }*/
        } else {
            println("Unable to write to file.")
        }
        
    }
    
    func convertToJSON(data:[[String:String]]) -> NSData {
        return NSJSONSerialization.dataWithJSONObject(data, options: nil, error: nil)!
    }
    
    func convertFromJSON() {
        
    }
    
    func convertJSONToString(data: NSData) -> String {
        return NSString(data: data, encoding: NSUTF8StringEncoding)!
    }
}
