//
//  ViewController.swift
//  TableViewPractise
//
//  Created by Mahesh Inna Kedage on 4/19/17.
//  Copyright © 2017 Mahesh Inna Kedage. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

   
    let people = ["item1","item2","item3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /*let people	 = [("Mahesh Inna Kedage, Singapore, 83470254"),
                  ("Soujanya Mahesh, India, 7259331060"),
                  ("Tanishka M, Mangalore, 7259331070")]
    
    let videos = ["Maine pyar kiya, Hindi Movie",
                  "Singam 1, Tamil Movie",
                  "Conjuring 2, English Movie",
                  "Arasu, Kannada Movie"]*/
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(tableView: UITableView, cellForRow indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let personname = people[indexPath.row] as String
        cell.textLabel?.text = personname
        return cell
    }
    
    

}

