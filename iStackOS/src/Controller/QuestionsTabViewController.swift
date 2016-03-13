//
//  QuestionsTabViewController.swift
//  iStackOS
//
//  Created by Marsal on 13/03/16.
//  Copyright © 2016 Marsal Silveira. All rights reserved.
//

import UIKit

class QuestionsTabViewController: UITableViewController
{
    // ********************************** //
    // MARK: <UIViewController> Lifecycle
    // ********************************** //

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        let restorationIdentifier1 = self.parentViewController?.restorationIdentifier
        let tagFilter1 = StackOverflowTag(rawValue: restorationIdentifier1!)
        
        Logger.log("\(tagFilter1)")

        // get tag filter using parentViewController... Each view controller is associated to one tag filter value...
        if let restorationIdentifier = self.parentViewController?.restorationIdentifier, let tagFilter = StackOverflowTag(rawValue: restorationIdentifier) {
            
            Logger.log(tagFilter.rawValue)
            DataSource.sharedInstance().loadDataWithTag(tagFilter)
        }
        else {
            showSimpleAlertWithTitle("Opps", message: "Não é possível encontrar a tag associada ao ViewController selecionado", viewController: self)
        }
    }
    
    // ********************************** //
    // MARK: <UITableViewDataSource>
    // ********************************** //

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    // ********************************** //
    // MARK: UITableViewDelegate
    // ********************************** //

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // ********************************** //
    // MARK: Navigation
    // ********************************** //

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}