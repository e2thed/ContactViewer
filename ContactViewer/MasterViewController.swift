//
//  MasterViewController.swift
//  ContactViewer
//
//  Created by Edward Castillo on 4/11/15.
//  Copyright (c) 2015 seng5199-3. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var fh = FileCabinet()
    var rsi = RolodexSpindle.sharedInstance
    

    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        self.navigationItem.title = "Contacts"

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
        
        if (fh.readFromFile() == 0) {
            let contact1 = Contact(name: "Walter White", phone: "612-664-1234", title: "Chemist", email: "walt@bb.com", twitterId: "ww")
            let contact2 = Contact(name: "Skyler White", phone: "612-664-1235", title: "Mom", email: "sky@bb.com", twitterId: "skyblue")
            let contact3 = Contact(name: "Jessie Pinkman", phone: "612-664-1236", title: "Junkie", email: "jessie@bb.com", twitterId: "jp")
            RolodexSpindle.sharedInstance.rolodex.append(contact1)
            RolodexSpindle.sharedInstance.rolodex.append(contact2)
            RolodexSpindle.sharedInstance.rolodex.append(contact3)
            
            fh.writeContactsToFile()
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
                let evc = AddContactViewController(nibName: "AddContactViewController", bundle: nil)
                self.navigationController?.pushViewController(evc, animated: true)

        //objects.insert(NSDate(), atIndex: 0)
        //let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        //self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = rsi.loadRolodexSpindle()[indexPath.row] as Contact
                let controller = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rsi.loadRolodexSpindle().count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        //let object = contacts[indexPath.row] as Contact
        let object = rsi.loadRolodexSpindle()[indexPath.row] as Contact
        cell.textLabel!.text = object.name
        //hack to avoid making custom cell
        cell.detailTextLabel!.text = "\(object.phone)       \(object.title)"
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //contacts.removeAtIndex(indexPath.row)
            let object = rsi.loadRolodexSpindle()[indexPath.row] as Contact
            rsi.deleteCard(object)
            fh.writeContactsToFile()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let evc = EditViewController(nibName: "EditViewController", bundle: nil)
//        self.navigationController?.pushViewController(evc, animated: true)
    }
}

