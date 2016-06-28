//
//  EventsDAOTests.swift
//  RioOlympics2016
//
//  Created by SpurYang on 15/11/25.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

import XCTest

class EventsDAOTests: XCTestCase {
    
    var dao: EventsDAO!
    var event: Events!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //创建EventsDAO对象
        self.dao = EventsDAO.sharedInstance
        //创建Events对象
        self.event = Events()
        event.EventName = "test EventName"
        event.EventIcon = "test EventIcon"
        event.KeyInfo = "test keyInfo"
        event.BasicsInfo = "test BasicsInfo"
        event.OlympicInfo = "test OlympicInfo"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        self.dao = nil
        self.event = nil
    }
    
    //测试插入数据
    func test_1_Create() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let res = self.dao.create(event)
        //断言返回值0
        XCTAssertEqual(res, 0)
    }
    //测试按主键查询数据
    func test_2_FindById() {
        self.event.EventID = 41
        let resEvent = self.dao.findById(event)
        
        //断言：查询结果非nil
        XCTAssertNotNil(resEvent)
        
        XCTAssertEqual(resEvent!.EventName!, event.EventName!)
        XCTAssertEqual(resEvent!.EventIcon!, event.EventIcon!)
        XCTAssertEqual(resEvent!.KeyInfo!, event.KeyInfo!)
        XCTAssertEqual(resEvent!.BasicsInfo!, event.BasicsInfo!)
        XCTAssertEqual(resEvent!.OlympicInfo!, event.OlympicInfo!)
    }
    
    //测试查询所有数据
    func test_3_FindAll() {
        let list = self.dao.findAll()
        
        //断言：查询记录数为1
        XCTAssertEqual(list.count, 41)
        
        let resEvent:Events? = list[40] as? Events
        
        XCTAssertEqual(resEvent!.EventName!, event.EventName!)
        XCTAssertEqual(resEvent!.EventIcon!, event.EventIcon!)
        XCTAssertEqual(resEvent!.KeyInfo!, event.KeyInfo!)
        XCTAssertEqual(resEvent!.BasicsInfo!, event.BasicsInfo!)
        XCTAssertEqual(resEvent!.OlympicInfo!, event.OlympicInfo!)
    }
    

    func test_4_Modify() {
        event.EventID = 41
        event.EventName = "test modify EventName"
        
        let res = self.dao.modify(event)
        
        XCTAssertEqual(res, 0)
        
        let resEvent = self.dao.findById(event)
        
        XCTAssertEqual(resEvent!.EventName!, event.EventName!)
        XCTAssertEqual(resEvent!.EventIcon!, event.EventIcon!)
        XCTAssertEqual(resEvent!.KeyInfo!, event.KeyInfo!)
        XCTAssertEqual(resEvent!.BasicsInfo!, event.BasicsInfo!)
        XCTAssertEqual(resEvent!.OlympicInfo!, event.OlympicInfo!)
    }
    
    //测试删除数据
    func test_5_Remove() {
        event.EventID = 41
        event.EventName = "test modify EventName"
        
        let res = self.dao.remove(event)
        
        XCTAssertEqual(res, 0)
        
        let resEvent = self.dao.findById(event)
        
        XCTAssertNil(resEvent)
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
