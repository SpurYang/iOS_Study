//
//  ScheduleBLTests.swift
//  RioOlympics2016
//
//  Created by SpurYang on 15/11/26.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

import XCTest

class ScheduleBLTests: XCTestCase {
    
    var bl: ScheduleBL!
    var schedule: Schedule!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        bl = ScheduleBL()
        
        schedule = Schedule()
        schedule.GameDate = "2016-08-21"
        schedule.GameInfo = "test gameInfo"
        schedule.GameTime = "test gameTime"
        let event = Events()
        event.EventID = 1
        schedule.Event = event
        
        let dao = ScheduleDAO.sharedInstance
        dao.create(schedule)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        let dao = ScheduleDAO.sharedInstance
        schedule.ScheduleID = 502
        dao.remove(schedule)
        
        bl = nil
        schedule = nil
        super.tearDown()
    }
    
    func test_1_readAll() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let resDict = bl.readAll()
        let resArray = resDict.objectForKey(schedule.GameDate!) as! NSArray
        
        //结果测试
        XCTAssertEqual(resDict.allKeys.count, 17)
        
        var sche: Schedule!
        var result = false
        for item in resArray {
            sche = item as! Schedule
            
            if sche.GameInfo! == schedule.GameInfo! &&
                sche.GameTime! == schedule.GameTime! &&
                 sche.Event!.EventID! == schedule.Event!.EventID! {
                    result = true
                    break
            }
        }
        
        XCTAssertNotNil(sche)
        XCTAssertTrue(result)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
