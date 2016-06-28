//
//  Schedule.swift
//  RioOlympics2016
//
//  Created by SpurYang on 15/11/24.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

import Foundation

class Schedule: NSObject {
    //编号
    var ScheduleID: Int?
    //比赛项目
    var Event: Events?
    //比赛日期
    var GameDate: NSString?
    //比赛时间
    var GameTime: NSString?
    //比赛描述
    var GameInfo: NSString?
}