//
//  AddContactViewController.swift
//  ContactViewer
//
//  Created by Edward Castillo on 4/13/15.
//  Copyright (c) 2015 seng5199-3. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController {

    let fh = FileCabinet()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Add Contact"
        let addButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "insertNewContact:")
        self.navigationItem.rightBarButtonItem = addButton
        // Do any additional setup after loading the view.
        
        /*if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            let path = dir.stringByAppendingPathComponent(file);
            
            //reading
            var textRead = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)
            
            var textWrite = "\(textRead) Test "
            //writing
            
            textWrite.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding, error: nil);
            if let outputStream = NSOutputStream(toFileAtPath: path, append: true) {
                outputStream.open()
                let text = "Hello World"
                outputStream.write(text, maxLength: 20000)
                
            }
            
            self.testLabel.text = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)
            
            
        }*/
        
        /*DataManager.getTopAppsDataFromFileWithSuccess { (data) -> Void in
            // Get the number 1 app using optional binding and NSJSONSerialization
            //1
            var parseError: NSError?
            let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data,
                options: NSJSONReadingOptions.AllowFragments,
                error:&parseError)
            
            //2
            if let topApps = parsedObject as? NSDictionary {
                if let feed = topApps["feed"] as? NSDictionary {
                    if let apps = feed["entry"] as? NSArray {
                        if let firstApp = apps[0] as? NSDictionary {
                            if let imname = firstApp["im:name"] as? NSDictionary {
                                if let appName = imname["label"] as? NSString {
                                    //3
                                    println("Optional Binding: \(appName)")
                                }
                            }
                        }
                    }
                }
            }
        }*/

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var cName: UITextField!
    @IBOutlet weak var cTwitter: UITextField!
    @IBOutlet weak var cEmail: UITextField!
    @IBOutlet weak var cPhoneNumber: UITextField!
    @IBOutlet weak var cTitle: UITextField!
    @IBOutlet weak var cNameLabel: UILabel!

    func insertNewContact(sender: AnyObject) {
        
        if(!cName.text.isEmpty ) {
            let newContact = Contact( name: cName.text, phone: cPhoneNumber.text, title: cTitle.text, email: cEmail.text, twitterId:cTwitter.text)
            RolodexSpindle.sharedInstance.addCard(newContact)
            fh.writeContactsToFile()
            //IDLabel.text = newContact.id
            NSLog("Cname: \(cName.text)")
                self.navigationController?.popToRootViewControllerAnimated(true)
        } else if (cName.text == "") {
            var alert = UIAlertController(title: "Error!", message: "Name is required.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            cNameLabel.textColor = UIColor.redColor()
}
        
        
        
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        let contact1 = Contact( name: "Walter White", phone: "612-664-1234", title: "Chemist", email: "walt@bb.com", twitterId: "ww")
        
    }
    
    
    @IBOutlet weak var testLabel: UILabel!

    
}
