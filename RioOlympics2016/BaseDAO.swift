//
//  BaseDAO.swift
//  RioOlympics2016
//
//  Created by SpurYang on 15/11/25.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

import Foundation

let DB_FILE_NAME = "app.db"

let dbFilePath = DBHelper.applicationDocumentsDirectoryFile(DB_FILE_NAME as NSString)!
var isFrist = true

class BaseDAO: NSObject {
    
    var db:COpaquePointer = nil
    
    override init() {
        //初始化数据库
        if isFrist {
            DBHelper.initDB()
            isFrist = false
        }

        
    }
    
    func openDB() -> Bool {
        if sqlite3_open(dbFilePath, &db) != SQLITE_OK{
            sqlite3_close(db)
            NSLog("数据库打开失败")
            return false
        }
        return true
    }
}