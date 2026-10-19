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
        db = createDatabase()           //function call
        createEmployeeTable()           //function call
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
    
    func createEmployeeTable(){
        let createQueryString = "CREATE TABLE IF NOT EXISTS Employee(employeeId INTEGER PRIMARY KEY NOT NULL, employeeName TEXT, employeeSalary DOUBLE);"
        var createStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(db,
                              createQueryString,
                              -1,
                              &createStatement,
                              nil) == SQLITE_OK{
            
            print("Create Employee Table Query prepared successfully")
            
            if sqlite3_step(createStatement) == SQLITE_DONE{
                print("Sqlite table is created successfully")
            }else{
                print("Sqlite table creation is unsuccessful")
            }
        }else{
            print("Create Employee Table Query preparation is unsuccessful")
        }
        sqlite3_finalize(createStatement)
    }
}
