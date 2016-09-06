//
//  CoursesViewController.swift
//  iSWAD
//
//  Created by Raul Alvarez on 13/06/2016.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//

import UIKit

class OrderMasterViewController: UITableViewController {
 
	var orderList:[String] = ["a","b","c","d"]
 
	//MARK: Table View Data Source and Delegate
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return orderList.count
	}
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
		cell.textLabel?.text = orderList[indexPath.row]
		if indexPath.row % 2 == 1 { //alternating row backgrounds
			cell.backgroundColor = UIColor.yellowColor()
		} else {
			cell.backgroundColor = tableView.backgroundColor
		}
		return cell
	}
} 