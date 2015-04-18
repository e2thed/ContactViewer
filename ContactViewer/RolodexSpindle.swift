//
//  Rolodex.swift
//  ContactViewer
//
//  Created by Ed Castillo on 4/17/15.
//  Copyright (c) 2015 seng5199-3. All rights reserved.
//

import Foundation

class RolodexSpindle : NSObject {
    var rolodex = [Contact]()
    
    class var sharedInstance: RolodexSpindle {
        struct Singleton {
            static let instance = RolodexSpindle()
        }
        return Singleton.instance
    }
    
    override init() {
//        let contact1 = Contact(name: "Walter White", phone: "612-664-1234", title: "Chemist", email: "walt@bb.com", twitterId: "ww")
//        let contact2 = Contact(name: "Skyler White", phone: "612-664-1235", title: "Mom", email: "sky@bb.com", twitterId: "skyblue")
//        let contact3 = Contact(name: "Jessie Pinkman", phone: "612-664-1236", title: "Junkie", email: "jessie@bb.com", twitterId: "jp")
//        rolodex.append(contact1)
//        rolodex.append(contact2)
//        rolodex.append(contact3)
    }
    
    func loadRolodexSpindle() -> [Contact] {
        return rolodex
    }
    
    func deleteCard(contact:Contact){
        if let index = find(rolodex, contact) {
            rolodex.removeAtIndex(index)
            NSLog("Contact at index: \(index) was removed.\n")
        } else {
            NSLog("Contact not found.\n")
        }
    }
    
    func addCard(contact : Contact){
        rolodex.append(contact)
    }
    
    func updateCard(id:String){
        
    }
}