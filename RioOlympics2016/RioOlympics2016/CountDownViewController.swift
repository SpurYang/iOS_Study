//
//  CountDownViewController.swift
//  RioOlympics2016
//
//  Created by SpurYang on 15/11/29.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

import UIKit

class CountDownViewController: UIViewController {

    @IBOutlet weak var lbCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let comps = NSDateComponents()
        comps.day = 5
        comps.month = 8
        comps.year = 2016
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        
        let destinationDate = calendar!.dateFromComponents(comps)
        let date = NSDate()
        
        //获取当前日期到2016-8-5的componts
        let componts = calendar!.components(NSCalendarUnit.NSDayCalendarUnit, fromDate: date, toDate: destinationDate!, options: NSCalendarOptions())
        
        //从componts中获取天数
        let days = componts.day
        
        let title = NSString(format: "%i天", days)
        lbCount.text = title as String
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
