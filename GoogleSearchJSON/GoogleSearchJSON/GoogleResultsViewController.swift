//
//  GoogleResultsTableViewController.swift
//  GoogleSearchJSON
//
//  Created by englieh on 26/12/14.
//  Copyright (c) 2014 ISS. All rights reserved.
//

import UIKit

class GoogleResultsViewController: UITableViewController {
    var searchResults:SearchResults!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return searchResults.searchTitles.count;

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        
        cell.textLabel!.text = (searchResults.searchTitles[indexPath.row] as AnyObject).description
       return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchResults.selectedLink = searchResults.searchLinks [indexPath.row] as! String;

    }
    
}
