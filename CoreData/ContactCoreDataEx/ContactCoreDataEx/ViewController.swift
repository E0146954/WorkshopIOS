//
//  ViewController.swift
//  ContactCoreDataEx
//
//  Created by student on 17/4/17.
//  Copyright © 2017 ISS. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var address: UITextField!
    
    @IBOutlet weak var phone: UITextField!
    
   
    @IBOutlet weak var status: UILabel!

    
     var contactObject: Contacts!
    let managedObjectContext = (UIApplication.shared.delegate as!
        AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func createContact(_ sender: AnyObject) {
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "Contacts",
                                       in: managedObjectContext)
        let contact = Contacts(entity: entityDescription!,
                               insertInto: managedObjectContext)
        contact.name = name.text
        contact.address = address.text
        contact.phone = phone.text
        do {
            try managedObjectContext.save()
            status.text = "Contact Saved"
        } catch let error as NSError {
            status.text = "Error: " + error.localizedFailureReason!
            print("Failed : \(error.localizedDescription)")
        } }
    @IBAction func updateContact(_ sender: AnyObject) {
        if (contactObject == nil)  {
            status.text = "Contact not found"
            return; }
        contactObject.address = address.text
        contactObject.phone = phone.text
        do {
            try managedObjectContext.save()
            status.text = "Contact updated"
        } catch let error as NSError {
            status.text = "Error: " + error.localizedFailureReason!
            print("Failed : \(error.localizedDescription)")
        } }
    
    @IBAction func deleteContact(_ sender: AnyObject) {
        if (contactObject == nil)  {
            status.text = "Contact not found"
            return; }
        managedObjectContext.delete(contactObject)
        do {
            try managedObjectContext.save()
            status.text = "Contact deleted"
        } catch let error as NSError {
            status.text = "Error: " + error.localizedFailureReason!
            print("Failed : \(error.localizedDescription)")
        }
        contactObject = nil
    }
    @IBAction func findContact(_ sender: AnyObject) {
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "Contacts",
                                       in: managedObjectContext)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entityDescription
        let pred = NSPredicate(format: "(name = %@)", name.text!)
        request.predicate = pred
        do {
            let results = try managedObjectContext.fetch(request)
            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                name.text = (match.value(forKey: "name") as! String)
                address.text = (match.value(forKey: "address")as! String)
                phone.text = (match.value(forKey: "phone") as! String)
                status.text = "Matches found: \(results.count)"
                contactObject = match as! Contacts
            } else {
                name.text = ""
                address.text = ""
                phone.text = ""
                status.text = "Record not found"
            }
        } catch let error as NSError {
            name.text = ""
            address.text = ""
            phone.text = ""
            status.text = "Error: " + error.localizedFailureReason!
            print("Failed : \(error.localizedDescription)")
        } }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

