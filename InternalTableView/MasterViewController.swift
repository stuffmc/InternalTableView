//
//  MasterViewController.swift
//  InternalTableView
//
//  Created by StuFF mc on 30/05/15.
//  Copyright (c) 2015 StuFF mc. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

  // MARK: - Table View

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if tableView.tag == 0 {
      return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
    return cell
  }

}

