//
//  EventsViewController.swift
//  RioOlympics2016
//
//  Created by SpurYang on 15/11/27.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

import UIKit

var COL_COUNT = 2

class EventsViewController: UICollectionViewController{

    var events: NSArray!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //判断当前设备，确定显示列数
        if UIDevice.currentDevice().userInterfaceIdiom ==
            UIUserInterfaceIdiom.Pad {
                COL_COUNT = 5
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reLoadData:", name: "InitDBFinished", object: nil)
        //从Model中获取数据
        events = EventsBL().readAll()
    }

    func reLoadData(notification: NSNotification) {
        dispatch_async(dispatch_get_main_queue(), {
            //这里返回主线程，写需要主线程执行的代码
            self.collectionView!.reloadData()
            self.collectionView!.setNeedsDisplay()
        })
        NSLog("xxxxxxxxxxxxxxxxxxxxxxxx")
    }
    
    
    //------DataSource------
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return events.count / COL_COUNT
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return COL_COUNT
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! EventsViewCell
        
        
        let index = indexPath.section * COL_COUNT + indexPath.row
        let event = events.objectAtIndex(index) as! Events
        cell.imageView.image = UIImage(named: event.EventIcon! as String)
        return cell
    }
    
    //------Delegate------
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier! == "showDetails" {
            //将选中的Events传给目标视图控制器
            let indexPaths = collectionView?.indexPathsForSelectedItems()!
            let index = indexPaths![0]
            let event = events.objectAtIndex(index.section * COL_COUNT + index.row) as! Events
            
            let destVC = segue.destinationViewController as! EventsDeatilViewController
            destVC.event = event
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    
    

    


}
