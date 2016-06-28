//
//  EventsBLTests.swift
//  RioOlympics2016
//
//  Created by SpurYang on 15/11/26.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

import XCTest

class EventsBLTests: XCTestCase {
    
    var eventsBL: EventsBL!
    var event: Events!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //创建逻辑层
        eventsBL = EventsBL()
        
        //创建测试Events实例
        event = Events()
        event.EventName = "test EventName"
        event.EventIcon = "test EventIcon"
        event.KeyInfo = "test keyInfo"
        event.BasicsInfo = "test BasicsInfo"
        event.OlympicInfo = "test OlympicInfo"
        
        //插入测试实例
        let dao = EventsDAO.sharedInstance
        dao.create(event)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        //删除测试实例
        let dao = EventsDAO.sharedInstance
        event.EventID = 41
        dao.remove(event)
        
        eventsBL = nil
        event = nil

        super.tearDown()
    }
    
    func test_readAll() {
        let res = eventsBL.readAll()
        
        let resEvent: Events? = res[40] as? Events
        
        //结果测试
        XCTAssertEqual(res.count, 41)
        
        XCTAssertEqual(resEvent!.EventName!, event.EventName!)
        XCTAssertEqual(resEvent!.EventIcon!, event.EventIcon!)
        XCTAssertEqual(resEvent!.KeyInfo!, event.KeyInfo!)
        XCTAssertEqual(resEvent!.BasicsInfo!, event.BasicsInfo!)
        XCTAssertEqual(resEvent!.OlympicInfo!, event.OlympicInfo!)
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
