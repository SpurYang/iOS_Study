//
//  ScheduleTableViewController.swift
//  RioOlympics2016
//
//  Created by SpurYang on 15/11/29.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

import UIKit

class ScheduleTableViewController: UITableViewController {

    
    var data: NSDictionary!
    var arrayGameDateList: NSArray!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        let bl = ScheduleBL()
        data = bl.readAll()
        let keys = data.allKeys as NSArray
        //排序
        arrayGameDateList = keys.sortedArrayUsingSelector("compare:") as NSArray
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reLoadData:", name: "InitDBFinished", object: 1)
        
    }

    func reLoadData(notification: NSNotification) {
        dispatch_async(dispatch_get_main_queue(), {
            //这里返回主线程，写需要主线程执行的代码
            self.tableView!.reloadData()
            self.tableView!.setNeedsDisplay()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return arrayGameDateList.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let items = data.objectForKey( arrayGameDateList.objectAtIndex(section) as! NSString) as! NSArray
        return items.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath)

        // Configure the cell...
        let strGameData = arrayGameDateList.objectAtIndex(indexPath.section) as! NSString
        let schedules = data.objectForKey(strGameData) as! NSArray
        let scheduel = schedules.objectAtIndex(indexPath.row) as! Schedule
        
        let subTitle = NSString(format: "%@ | %@", scheduel.GameInfo!,scheduel.Event!.EventName!)
        
        cell.textLabel!.text = scheduel.GameTime! as String
        cell.detailTextLabel!.text = subTitle as String
        
        return cell
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        let array = NSMutableArray()
        for item in arrayGameDateList {
            let str = item as! NSString
            array.addObject(str.substringFromIndex(5))
        }
        
        return array as NSArray as? [String]
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = arrayGameDateList.objectAtIndex(section) as! String
        return title
        
        
        
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEd itRowAtIndexPath indexPath: NSIndexPath) -> Bool {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
