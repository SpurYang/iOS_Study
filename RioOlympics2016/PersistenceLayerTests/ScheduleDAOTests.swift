//
//  ScheduleDAOTests.swift
//  RioOlympics2016
//
//  Created by SpurYang on 15/11/25.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

import XCTest

class ScheduleDAOTests: XCTestCase {

    var dao: ScheduleDAO!
    var schedule: Schedule!
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.dao = ScheduleDAO.sharedInstance
        
        self.schedule = Schedule()
        schedule.GameDate = "2016-08-21"
        schedule.GameInfo = "test gameInfo"
        schedule.GameTime = "test gameTime"
        let event = Events()
        event.EventID = 1
        schedule.Event = event
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        self.dao = nil
        self.schedule = nil
    }

    //测试插入数据
    func test_1_Create() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let res = self.dao.create(schedule)
        //断言返回值0
        XCTAssertEqual(res, 0)
    }
    
    //测试按主键查询数据
    func test_2_FindById() {
        self.schedule.ScheduleID = 502
        let res = self.dao.findById(schedule)
        
        //断言：查询结果非nil
        XCTAssertNotNil(res)
        
        XCTAssertEqual(res!.GameDate!, schedule!.GameDate!)
        XCTAssertEqual(res!.GameTime!, schedule!.GameTime!)
        XCTAssertEqual(res!.GameInfo!, schedule!.GameInfo!)
        //XCTAssertEqual(res!.Event!.EventID!, schedule!.Event!.EventID!)
    }
    
    //测试查询所有数据
    func test_3_FindAll() {
        let list = self.dao.findAll()
        
        //断言：查询记录数为1
        XCTAssertEqual(list.count, 502)
        
        let res:Schedule? = list[501] as? Schedule
        
        XCTAssertEqual(res!.GameDate!, schedule!.GameDate!)
        XCTAssertEqual(res!.GameTime!, schedule!.GameTime!)
        XCTAssertEqual(res!.GameInfo!, schedule!.GameInfo!)
        //XCTAssertEqual(res!.Event!.EventID!, schedule!.Event!.EventID!)
    }
    
    
    func test_4_Modify() {
        schedule.ScheduleID = 502
        schedule.GameInfo = "test modify GameInfo"
        
        let resVaule = self.dao.modify(schedule)
        
        XCTAssertEqual(resVaule, 0)
        
        let res = self.dao.findById(schedule)
        
        XCTAssertEqual(res!.GameDate!, schedule!.GameDate!)
        XCTAssertEqual(res!.GameTime!, schedule!.GameTime!)
        XCTAssertEqual(res!.GameInfo!, schedule!.GameInfo!)
        //XCTAssertEqual(res!.Event!.EventID!, schedule!.Event!.EventID!)
    }
    
    //测试删除数据
    func test_5_Remove() {
        schedule.ScheduleID = 502
        //schedule.GameInfo = "test modify GameInfo"
        
        let resVaule = self.dao.remove(schedule)
        
        XCTAssertEqual(resVaule, 0)
        
        let res = self.dao.findById(schedule)
        
        XCTAssertNil(res)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
