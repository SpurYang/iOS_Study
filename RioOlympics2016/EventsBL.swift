//
//  EventsBL.swift
//  RioOlympics2016
//
//  Created by SpurYang on 15/11/26.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

import Foundation

class EventsBL: NSObject {
    
    func readAll() -> NSMutableArray {
        var retValue = NSMutableArray()
        let dao = EventsDAO.sharedInstance
        retValue = dao.findAll()
        return retValue
    }
}
