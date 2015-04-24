//
//  DetailViewController.swift
//  ContactViewer
//
//  Created by Edward Castillo on 4/11/15.
//  Copyright (c) 2015 seng5199-3. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailPhone: UILabel!
    @IBOutlet weak var detailEmail: UILabel!
    @IBOutlet weak var detailTwitter: UILabel!
    
    var editViewController: EditViewController? = nil
    
    var detailItem: Contact? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail: Contact = self.detailItem {
            if let labelName = self.detailName {
                labelName.text = detail.name
            }
            if let labelTitle = self.detailTitle {
                labelTitle.text = detail.title
            }
            if let labelPhone = self.detailPhone {
                labelPhone.text = detail.phone
            }
            if let labelEmail = self.detailEmail {
                labelEmail.text = detail.email
            }
            if let labelTwitter = self.detailTwitter {
                labelTwitter.text = detail.twitterId
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        let editButton = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "editContact:")
        self.navigationItem.rightBarButtonItem = editButton
       // if let split = self.splitViewController {
       //     let controllers = split.viewControllers
       //     self.editViewController = controllers[controllers.count-1].topViewController as? EditViewController
       // }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.configureView()
    }
    
    func editContact(sender: AnyObject) {
        let evc = EditViewController(nibName: "EditViewController", bundle: nil)
        evc.detailItem = detailItem
       // evc.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
        evc.navigationItem.leftItemsSupplementBackButton = true
        self.navigationController?.pushViewController(evc, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

