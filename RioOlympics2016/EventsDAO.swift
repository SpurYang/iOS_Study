//
//  EventsDAO.swift
//  RioOlympics2016
//
//  Created by SpurYang on 15/11/25.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

import Foundation

class EventsDAO: BaseDAO {
    //单例模式
    class var sharedInstance: EventsDAO{
        struct Static {
            static var instance: EventsDAO?
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Static.token){
            Static.instance = EventsDAO()
        }
        return Static.instance!
    }
    
    //插入数据的
    func create(model: Events)->Int{
        if openDB() {
            let sql = "insert into Events(EventName,EventIcon,KeyInfo,BasicsInfo,OlympicInfo) values(?,?,?,?,?)"
            var statement: COpaquePointer = nil
            
            //预处理过程
            if sqlite3_prepare_v2(db, sql.cStringUsingEncoding(NSUTF8StringEncoding)!, -1, &statement, nil) == SQLITE_OK {
                //绑定参数
                sqlite3_bind_text(statement, 1, model.EventName!.cStringUsingEncoding(NSUTF8StringEncoding), -1, nil)
                sqlite3_bind_text(statement, 2, model.EventIcon!.cStringUsingEncoding(NSUTF8StringEncoding), -1, nil)
                sqlite3_bind_text(statement, 3, model.KeyInfo!.cStringUsingEncoding(NSUTF8StringEncoding), -1, nil)
                sqlite3_bind_text(statement, 4, model.BasicsInfo!.cStringUsingEncoding(NSUTF8StringEncoding), -1, nil)
                sqlite3_bind_text(statement, 5, model.OlympicInfo!.cStringUsingEncoding(NSUTF8StringEncoding), -1, nil)
                
                //执行插入
                if sqlite3_step(statement) != SQLITE_DONE {
                    assert(false, "数据库插入数据失败")
                }
            }
            //释放资源
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return 0
    }
    //删除数据
    func remove(model: Events)->Int{
        if openDB() {
            //先删除子表中的所有相关数据
            let scheSql = NSString(format: "delete from Schedule where EventID = %i", model.EventID!)
            
            //开启事务，立刻提交之前的事务
            sqlite3_exec(db, "BEGIN IMMEDIATE TRANSACTION", nil, nil, nil)
            
            if sqlite3_exec(db, scheSql.cStringUsingEncoding(NSUTF8StringEncoding),nil, nil, nil) != SQLITE_OK {
                sqlite3_exec(db, "ROLLBACK TRANSACTION", nil, nil, nil)
                assert(false, "删除数据失败")
            }
            
            //删除主表中的数据
            let eventSql = NSString(format: "delete from Events where EventID = %i", model.EventID!)
            if sqlite3_exec(db, eventSql.cStringUsingEncoding(NSUTF8StringEncoding), nil, nil, nil) != SQLITE_OK {
                sqlite3_exec(db, "ROLLBACK TRANSACTION", nil, nil, nil)
                assert(false, "删除数据失败")
            }
            
            //提交事务
            sqlite3_exec(db, "COMMIT  TRANSACTION", nil, nil, nil)
            
            sqlite3_close(db)
        }
        return 0
    }
    
    //修改数据
    func modify(model: Events)->Int{
        if openDB() {
            let sql = "update Events set EventName='\(model.EventName!)',EventIcon='\(model.EventIcon!)',KeyInfo='\(model.KeyInfo!)',BasicsInfo='\(model.BasicsInfo!)',OlympicInfo='\(model.OlympicInfo!)' where EventID = \(model.EventID!)"
            if sqlite3_exec(db, sql.cStringUsingEncoding(NSUTF8StringEncoding)!, nil, nil, nil) != SQLITE_OK {
                assert(false, "数据修改失败")
            }
        }
        return 0
    }
    //查询所有数据
    func findAll() -> NSMutableArray{
        let listData = NSMutableArray()
        
        if openDB() {
            let sql = NSString(format: "select * from Events")
            var statement: COpaquePointer = nil
            
            if sqlite3_prepare_v2(db, sql.cStringUsingEncoding(NSUTF8StringEncoding), -1, &statement, nil) == SQLITE_OK {
                //遍历接过集
                while sqlite3_step(statement) == SQLITE_ROW {
                    let event = Events()
                    
                    event.EventName = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 1)))
                    event.EventIcon = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 2)))
                    event.KeyInfo = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 3)))
                    event.BasicsInfo = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 4)))
                    event.OlympicInfo = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 5)))
                    
                    listData.addObject(event)
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return listData
    }
    //通过主键查询数据
    func findById(model: Events) -> Events?{
        var retEvent: Events?
        
        if openDB() {
            let sql = NSString(format: "select * from Events where EventID = %i",model.EventID!)
            var statement: COpaquePointer = nil
            
            if sqlite3_prepare_v2(db, sql.cStringUsingEncoding(NSUTF8StringEncoding), -1, &statement, nil) == SQLITE_OK {
                //遍历接过集
                let value = sqlite3_step(statement)
                
                if value == SQLITE_ROW {
                    let event = Events()
                    event.EventID = Int(sqlite3_column_int(statement, 0))
                    event.EventName = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 1)))
                    event.EventIcon = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 2)))
                    event.KeyInfo = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 3)))
                    event.BasicsInfo = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 4)))
                    event.OlympicInfo = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 5)))
                    
                    retEvent = event
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return retEvent
    }
    
}