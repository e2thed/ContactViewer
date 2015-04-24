//
//  EditViewController.swift
//  ContactViewer
//
//  Created by Edward Castillo on 4/11/15.
//  Copyright (c) 2015 seng5199-3. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    let fh = FileCabinet()
    var rsi = RolodexSpindle.sharedInstance

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Edit Contact"
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "updateContact:")
        self.navigationItem.rightBarButtonItem = doneButton
        
        self.configureView()
        // Do any additional setup after loading the view.
    }
 
    @IBOutlet weak var editNameLabel: UILabel!
    @IBOutlet weak var editName: UITextField!
    @IBOutlet weak var editTitle: UITextField!
    @IBOutlet weak var editPhone: UITextField!
    @IBOutlet weak var editEmail: UITextField!
    @IBOutlet weak var editTwitter: UITextField!
    
    var detailItem: Contact? {
        didSet {
            // Update the view.
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail: Contact = self.detailItem {
            if let textName = self.editName {
                textName.text = detail.name
            }
            if let textTitle = self.editTitle {
                textTitle.text = detail.title
            }
            if let textPhone = self.editPhone {
                textPhone.text = detail.phone
            }
            if let textEmail = self.editEmail {
                textEmail.text = detail.email
            }
            if let textTwitter = self.editTwitter {
                textTwitter.text = detail.twitterId
            }
        }
        
    }

    func updateContact(sender: AnyObject) {
        
        if(!editName.text.isEmpty ) {
            var id = self.detailItem!
            let updateContact = Contact( uuid: id.uuid, name: editName.text, phone: editPhone.text, title: editTitle.text, email: editEmail.text, twitterId: editTwitter.text)
            rsi.updateCard(updateContact)
            fh.writeContactsToFile()
            //IDLabel.text = newContact.id
            NSLog("editName: \(editName.text)")
            self.navigationController?.popViewControllerAnimated(false)
        } else if (editName.text == "") {
            var alert = UIAlertController(title: "Error!", message: "Name is required.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            editNameLabel.textColor = UIColor.redColor()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
