//
//  fileHandler.swift
//  ContactViewer
//
//  Created by Ed Castillo on 4/14/15.
//  Copyright (c) 2015 seng5199-3. All rights reserved.
//

import Foundation
class FileCabinet: NSObject {
    
    let file = "contacts.json"
    var textRead = ""
    
    func readFromFile () -> Int {
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            let path = dir.stringByAppendingPathComponent(file);
            if let testVar = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)
            {
                textRead = testVar
            }
            else
            {
                return 0
            }
            let jData:NSData? = textRead.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
            var err = NSError?()
            var jArray:NSArray = NSJSONSerialization.JSONObjectWithData(jData!, options: NSJSONReadingOptions.MutableContainers, error: &err)! as NSArray
            
            //println(jArray.objectAtIndex(0).objectForKey("name")!)
            
            convertFromJSON(jArray)
            
        } else {
            //throw alert
            return -1
        }
        return RolodexSpindle.sharedInstance.rolodex.count
    }
    
    func writeContactsToFile () {
        var dataWrite = convertToJSON()
        
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            let path = dir.stringByAppendingPathComponent(file);
            
            dataWrite.writeToFile(path, atomically: false)

        } else {
            println("Unable to write to file.")
        }
    }
    
    func convertToJSON() -> NSData {
        var data = [NSDictionary]()
        var myDict = NSDictionary()
        var deck = RolodexSpindle.sharedInstance.rolodex
        for var i = 0; i < RolodexSpindle.sharedInstance.rolodex.count; ++i {
            myDict = [
                "uuid":deck[i].uuid,
                "name":deck[i].name,
                "title":deck[i].title,
                "phone":deck[i].phone,
                "email":deck[i].email,
                "twitterId":deck[i].twitterId
                ] as NSDictionary
            data.append(myDict)
        }
        
        var error = NSError?()
        var tmpJSON = NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions.allZeros, error: &error)!
//        let str = NSString(data: tmpJSON, encoding:NSUTF8StringEncoding)!
//        println(str)
        return tmpJSON
    }
    
    func convertFromJSON(data:NSArray) {
        for (item) in data {
            RolodexSpindle.sharedInstance.rolodex.append(mapfrom(item as NSDictionary))
        }
    }
    
    func mapfrom(element:NSDictionary) -> Contact{
        return Contact(
            uuid: (element["uuid"] as AnyObject? as String),
            name: (element["name"] as AnyObject? as String),
            phone: (element["phone"] as AnyObject? as String),
            title: (element["title"] as AnyObject? as String),
            email: (element["email"] as AnyObject? as String),
            twitterId: (element["twitterId"] as AnyObject? as String)
)
    }
    
    func convertJSONToString(data: NSData) -> String {
        return NSString(data: data, encoding: NSUTF8StringEncoding)!
    }
}
