//
//  ViewController.swift
//  AnnotateLocation
//
//  Created by student on 17/4/17.
//  Copyright © 2017 ISS. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {
    
    var contacts: [Contact]!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var status: UILabel!
    
    var contactDB : OpaquePointer? = nil;  // pointer to the database
    var insertStatement : OpaquePointer? = nil;  // pointer to the prepared
    //statement
    @IBOutlet weak var tableView: UITableView!
    var selectStatement : OpaquePointer? = nil;
    var updateStatement : OpaquePointer? = nil;
    var deleteStatement : OpaquePointer? = nil;
    var queryStatement : OpaquePointer? = nil;
    let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contacts = []
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        print(paths)
        let docsDir = paths + "/contacts.sqlite"
        if (sqlite3_open(docsDir, &contactDB) == SQLITE_OK)
        {
            let sql = "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT, PHONE TEXT)"
            if (sqlite3_exec(contactDB, sql,nil,nil, nil) != SQLITE_OK) {
                print("Failed to create table")
                print(sqlite3_errmsg(contactDB));
            } }
        else {
            print("Failed to open database")
            print(sqlite3_errmsg(contactDB));
        }
        prepareStartment();
        tableView.dataSource = self
        getAllContactData()
    }
    
    func prepareStartment () {
        var sqlString : String
        sqlString = "INSERT INTO CONTACTS (name, address, phone) VALUES (?, ?, ?)"
        var cSql = sqlString.cString(using: String.Encoding.utf8)
        sqlite3_prepare_v2(contactDB, cSql!, -1, &insertStatement,nil)
        sqlString = "SELECT address, phone FROM contacts WHERE name=?"
        cSql = sqlString.cString(using: String.Encoding.utf8)
        sqlite3_prepare_v2(contactDB, cSql!, -1, &selectStatement,nil)
        sqlString = "UPDATE CONTACTS SET address = ?, phone =? WHERE name = ?"
        cSql = sqlString.cString(using: String.Encoding.utf8)
        sqlite3_prepare_v2(contactDB, cSql!, -1, &updateStatement,nil)
        sqlString = "DELETE FROM CONTACTS WHERE name = ?"
        cSql = sqlString.cString(using: String.Encoding.utf8)
        sqlite3_prepare_v2(contactDB, cSql!, -1, &deleteStatement,nil)
        sqlString = "SELECT name, address, phone FROM CONTACTS order by name asc "
        cSql = sqlString.cString(using: String.Encoding.utf8)
        sqlite3_prepare_v2(contactDB, cSql!, -1, &queryStatement,nil)
    }
    
    func getAllContactData() {
        contacts.removeAll()
        
        while sqlite3_step(queryStatement) == SQLITE_ROW {
            
            let current = Contact()
            
            let name_buf = sqlite3_column_text(queryStatement, 0)
            current.name = String(cString: name_buf!)
            
            let address_buf = sqlite3_column_text(queryStatement, 1)
            current.address = String(cString: address_buf!)
            
            let phone_buf = sqlite3_column_text(queryStatement, 2)
            current.phone  = String(cString: phone_buf!)
            
            contacts.append(current)
        }
        
        sqlite3_reset(queryStatement)
        
        tableView.reloadData()
    }
 
    @IBAction func createContact(_ sender: Any) {
        let nameStr = name.text as NSString?
        let addressStr = address.text as NSString?
        let phoneStr = phone.text as NSString?
        sqlite3_bind_text(insertStatement, 1, nameStr!.utf8String, -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 2, addressStr!.utf8String , -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 3, phoneStr!.utf8String , -1, SQLITE_TRANSIENT);
        if (sqlite3_step(insertStatement) == SQLITE_DONE)
        {
            status.text = "Contact added";
        }
        else {
            status.text = "Failed to add contact";
            print("Error code: ", sqlite3_errcode (contactDB));
            let error = String(cString: sqlite3_errmsg(contactDB));
            print("Error msg: ", error);
        }
        sqlite3_reset(insertStatement);
        sqlite3_clear_bindings(insertStatement);
    }
  
    @IBAction func findContact(_ sender: Any) {
        let nameStr = name.text as NSString?
        sqlite3_bind_text(selectStatement, 1, nameStr!.utf8String, -1, SQLITE_TRANSIENT);
        if (sqlite3_step(selectStatement) == SQLITE_ROW)
        {
            status.text = "Record retrieved";
            let address_buf = sqlite3_column_text(selectStatement, 0)
            address.text = String(cString: address_buf!)
            let phone_buf = sqlite3_column_text(selectStatement, 1)
            phone.text  = String(cString: phone_buf!)
        }
        else {
            status.text = "Failed to retrieve contact";
            address.text = " ";
            phone.text = " "
            print("Error code: ", sqlite3_errcode (contactDB));
            let error = String(cString: sqlite3_errmsg(contactDB));
            print("Error msg: ", error);
        }
        sqlite3_reset(selectStatement);
        sqlite3_clear_bindings(selectStatement);

    }
    @IBAction func updateContact(_ sender: Any) {
        let nameStr = name.text as NSString?
        let addressStr = address.text as NSString?
        let phoneStr = phone.text as NSString?
        sqlite3_bind_text(updateStatement, 1, addressStr!.utf8String , -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStatement, 2, phoneStr!.utf8String , -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStatement, 3, nameStr!.utf8String , -1, SQLITE_TRANSIENT);
        if (sqlite3_step(updateStatement) == SQLITE_DONE)
        {
            status.text = "Contact updated";
        }
        else {
            status.text = "Failed to update contact";
            print("Error code: ", sqlite3_errcode (contactDB));
            let error = String(cString: sqlite3_errmsg(contactDB));
            print("Error msg: ", error);
        }
        sqlite3_reset(updateStatement);
        sqlite3_clear_bindings(updateStatement);

    }
    @IBAction func deleteContact(_ sender: Any) {
        let nameStr = name.text as NSString?
        sqlite3_bind_text(deleteStatement, 1, nameStr!.utf8String, -1, SQLITE_TRANSIENT);
        if (sqlite3_step(deleteStatement) == SQLITE_DONE)
        {
            status.text = "Contact deleted";
        }
        else {
            status.text = "Failed to delete contact";
            print("Error code: ", sqlite3_errcode (contactDB));
            let error = String(cString: sqlite3_errmsg(contactDB));
            print("Error msg: ", error);
        }
        sqlite3_reset(deleteStatement);
        sqlite3_clear_bindings(deleteStatement);
    }
 
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // set the number of rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
        
    }
    
    // set the contents of the tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell {
        let cell = UITableViewCell()
        // names is an array of string
        let currentContact = contacts[indexPath.row] as Contact
        cell.textLabel?.text = currentContact.name! + " - " + currentContact.address! + " ( " + currentContact.phone! + " )"
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

