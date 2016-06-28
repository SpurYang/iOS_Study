//
//  ScheduleBL.swift
//  RioOlympics2016
//
//  Created by SpurYang on 15/11/26.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

import Foundation


class ScheduleBL: NSObject {
    
    func readAll() -> NSMutableDictionary {
        let retDict = NSMutableDictionary()
        let dao = ScheduleDAO.sharedInstance
        let array = dao.findAll()
        
        
        for item in array {
            let sche = item as! Schedule
            //查询Schedule对应的Event
            let event = Events()
            event.EventID = sche.Event!.EventID!
            sche.Event = EventsDAO.sharedInstance.findById(event)
            
            let allKey = retDict.allKeys as NSArray
            if allKey.containsObject(sche.GameDate!) {
                let value = retDict.objectForKey(sche.GameDate!) as! NSMutableArray
                value.addObject(sche)
            }else{
                let value = NSMutableArray()
                value.addObject(sche)
                retDict.setObject(value, forKey: sche.GameDate!)
            }
        }
        return retDict
    }
}