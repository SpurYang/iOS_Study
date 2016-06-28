//
//  ScheduleDAO.swift
//  RioOlympics2016
//
//  Created by SpurYang on 15/11/25.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

import Foundation


class ScheduleDAO: BaseDAO {
    //单例模式
    class var sharedInstance: ScheduleDAO{
        struct Static {
            static var instance: ScheduleDAO?
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Static.token){
            Static.instance = ScheduleDAO()
        }
        return Static.instance!
    }
    
    //插入数据的
    func create(model: Schedule)->Int{
        if openDB() {
            let sql = "insert into Schedule(GameDate,GameTime,GameInfo,EventID) values(?,?,?,?)"
            var statement: COpaquePointer = nil
            
            //预处理过程
            if sqlite3_prepare_v2(db, sql.cStringUsingEncoding(NSUTF8StringEncoding)!, -1, &statement, nil) == SQLITE_OK {
                //绑定参数
                sqlite3_bind_text(statement, 1, model.GameDate!.cStringUsingEncoding(NSUTF8StringEncoding), -1, nil)
                sqlite3_bind_text(statement, 2, model.GameTime!.cStringUsingEncoding(NSUTF8StringEncoding), -1, nil)
                sqlite3_bind_text(statement, 3, model.GameInfo!.cStringUsingEncoding(NSUTF8StringEncoding), -1, nil)
                sqlite3_bind_int(statement, 4, Int32(model.Event!.EventID!))
                
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
    func remove(model: Schedule)->Int{
        if openDB() {
            
            let scheSql = NSString(format: "delete from Schedule where ScheduleID = %i", model.ScheduleID!)
            
            if sqlite3_exec(db, scheSql.cStringUsingEncoding(NSUTF8StringEncoding),nil, nil, nil) != SQLITE_OK {
                assert(false, "删除数据失败")
            }
            sqlite3_close(db)
        }
        return 0
    }
    
    //修改数据
    func modify(model: Schedule)->Int{
        if openDB() {
            let sql = "update Schedule set GameDate='\(model.GameDate!)',GameTime='\(model.GameTime!)',GameInfo='\(model.GameInfo!)',EventID=\(model.Event!.EventID!)  where ScheduleID = \(model.ScheduleID!)"
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
            let sql = NSString(format: "select * from Schedule")
            var statement: COpaquePointer = nil
            
            if sqlite3_prepare_v2(db, sql.cStringUsingEncoding(NSUTF8StringEncoding), -1, &statement, nil) == SQLITE_OK {
                //遍历接过集
                while sqlite3_step(statement) == SQLITE_ROW {
                    let sche = Schedule()
                    
                    sche.ScheduleID = Int((sqlite3_column_int(statement, 0)))
                    sche.GameDate = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 1)))
                    sche.GameTime = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 2)))
                    sche.GameInfo = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 3)))
                    //-------------------------------
                    sche.Event = Events()
                    sche.Event!.EventID = Int(sqlite3_column_int(statement, 4))
                    
                    listData.addObject(sche)
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return listData
    }
    //通过主键查询数据
    func findById(model: Schedule) -> Schedule?{
        var retSche: Schedule?
        if openDB() {
            let sql = NSString(format: "select * from Schedule where ScheduleID = %i",model.ScheduleID!)
            var statement: COpaquePointer = nil
            
            if sqlite3_prepare_v2(db, sql.cStringUsingEncoding(NSUTF8StringEncoding), -1, &statement, nil) == SQLITE_OK {
                //遍历接过集
                let value = sqlite3_step(statement)
                
                if value == SQLITE_ROW {
                    let sche = Schedule()
                    
                    sche.ScheduleID = Int(sqlite3_column_int(statement, 0))
                    sche.GameDate = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 1)))
                    sche.GameTime = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 2)))
                    sche.GameInfo = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement, 3)))
                    //-------------------------------
                    sche.Event = Events()
                    sche.Event!.EventID = Int(sqlite3_column_int(statement, 4))
                    
                    retSche = sche
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return retSche
    }

}