//
//  Contact.swift
//  ContactViewer
//
//  Created by Edward Castillo on 4/11/15.
//  Copyright (c) 2015 seng5199-3. All rights reserved.
//

import Foundation


class Contact: NSObject {
    var uuid:String
    var name:String
    var title:String
    var email:String
    var phone:String
    var twitterId:String
    
    init(uuid:String,name:String, phone:String, title:String, email:String, twitterId:String) {
        self.uuid = uuid
        self.name = name
        self.phone = phone
        self.title = title
        self.email = email
        self.twitterId = twitterId
    }
    init(name:String, phone:String, title:String, email:String, twitterId:String) {
        self.uuid = NSUUID().UUIDString
        self.name = name
        self.phone = phone
        self.title = title
        self.email = email
        self.twitterId = twitterId
    }
 
}