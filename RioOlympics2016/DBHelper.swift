//
//  DBHelper.swift
//  RioOlympics2016
//
//  Created by SpurYang on 15/11/24.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

import Foundation

struct DBHelper {
    
    static var db: COpaquePointer = nil
    
    //获取document文件夹下数据库文件路径
    static func applicationDocumentsDirectoryFile(fileName: NSString)->[CChar]?{
        //获取本应用document文件夹路径
        let documentDirectory: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        //拼接document文件夹下制定文件的路径
        
        let path = documentDirectory[0].stringByAppendingPathComponent(fileName as String) as String
        //---------------模拟器测试指定路径-------------------
            //path = "/Users/Spuryang/Desktop/IOSdevTest/app.db"
        //-------------------------------------------------
        NSLog("path:%@", path)
        let cpath = path.cStringUsingEncoding(NSUTF8StringEncoding)

        return cpath
    }
    
    //初始化并加载数据
    static func initDB(){
        //获取数据库版本配置属性列表文件路径
        let configTablePath = NSBundle.mainBundle().pathForResource("DBConfig", ofType: "plist")!
        NSLog("config.plist Path:%@", configTablePath)
        //获取配置文件中数据库版本
        let configTable = NSDictionary(contentsOfFile: configTablePath)
        var dbConfigVersion = configTable?.objectForKey("DB_VERSION") as! NSNumber?
        if (dbConfigVersion == nil){
            dbConfigVersion = NSNumber(integer: 0)
        }
        //从数据库DBVersionInfo中获取数据库版本
        let verionNumber: Int = DBHelper.dbVersionNumber()
        
        if dbConfigVersion!.integerValue != verionNumber{
            let DBPath = applicationDocumentsDirectoryFile(DB_FILE_NAME)
            
            if sqlite3_open(DBPath!,&db) == SQLITE_OK{
                //初始化数据库
                
                //let sqlPath = NSBundle.mainBundle().pathForResource("RioOlympic2016", ofType: "sql")!
                let sqlPath = NSBundle.mainBundle().pathForResource("create_load", ofType: "sql")!
                var sql: NSString? = nil
                do{
                    sql = try NSString(contentsOfFile: sqlPath, encoding: NSUTF8StringEncoding)

                }catch{
                    assert(false, "sql脚本加载失败")
                }
                let cSql = sql!.cStringUsingEncoding(NSUTF8StringEncoding)
                
                //执行初始化DDL脚本
                sqlite3_exec(db, cSql, nil, nil, nil)
                
                //把当前版本号写回数据库中
                let uSql = NSString(format: "update DBVersionInfo set version_number = %i", dbConfigVersion!.integerValue)
                sqlite3_exec(db, uSql.cStringUsingEncoding(NSUTF8StringEncoding), nil, nil, nil)
                
                sqlite3_close(db)
            }
            
        }
    }
    
    static func dbVersionNumber()->Int{
        var versionNumber = -1
        
        let dbFilePath = applicationDocumentsDirectoryFile(DB_FILE_NAME)
        if sqlite3_open(dbFilePath!, &db) == SQLITE_OK{
            let sql = "create tabel if not exists DBVersionInfo(version_number INTEGER)"
            let res1 = sqlite3_exec(db, sql.cStringUsingEncoding(NSUTF8StringEncoding)!, nil, nil, nil)
            
            let qSql = "select version_number from DBVersionInfo"
            var statement: COpaquePointer = nil
            //sql语句预处理
            let res2 = sqlite3_prepare_v2(db, qSql.cStringUsingEncoding(NSUTF8StringEncoding)!, -1, &statement, nil)
            if res2 == SQLITE_OK{
                //查询
                if sqlite3_step(statement) == SQLITE_ROW{
                    NSLog("DBVersionInfo有数据")
                    versionNumber = Int.init(String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement,0)))!)!
                }else{
                    NSLog("DBVersionInfo无数据")
                    let insertSql = "insert into DBVersionInfo(version_number) values(-1)"
                    sqlite3_exec(db, insertSql.cStringUsingEncoding(NSUTF8StringEncoding)!, nil, nil, nil)
                }
            }else {
                NSLog("DBVersionInfo无数据")
                let insertSql = "insert into DBVersionInfo(version_number) values(-1)"
                sqlite3_exec(db, insertSql.cStringUsingEncoding(NSUTF8StringEncoding)!, nil, nil, nil)
            }
            //释放资源
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return versionNumber
    }
    
    
}