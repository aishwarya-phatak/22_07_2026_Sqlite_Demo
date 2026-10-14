//
//  File.swift
//  22_07_2026_Sqlite_Demo
//
//  Created by Vishal Jagtap on 14/10/26.
//

import Foundation
import SQLite3

final class DBHelper{
    
    static let shared = DBHelper()
    var db : OpaquePointer?
    var dbName : String = "mysqlite.db"
    
    private init() {
        db = createDatabase()
    }
    
    func createDatabase() -> OpaquePointer?{
        let fileUrl = try! FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor : nil,
            create: false).appendingPathComponent(dbName)
        
        print(fileUrl)
        
        if sqlite3_open(fileUrl.path(), &db) == SQLITE_OK{
            print("database is created successfully")
            return db
        }else{
            print("database is not created successfully")
            return nil
        }
    }
}
