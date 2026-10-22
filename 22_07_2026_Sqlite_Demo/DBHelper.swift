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
    var employees : [Employee] = []
    
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
        let createQueryString = "CREATE TABLE IF NOT EXISTS Employee(employeeId INTEGER PRIMARY KEY, employeeName TEXT, employeeSalary DOUBLE);"
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
    
    func insertDataIntoTable(empId : Int, empName : String, empSalary : Double){
        
        let insertQueryString = "INSERT INTO Employee(employeeId, employeeName, employeeSalary) VALUES (?,?,?);"
        var insertStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(db,
                              insertQueryString,
                              -1,
                              &insertStatement,
                              nil) == SQLITE_OK{
            print("insert query preparation was successful")
            
            if sqlite3_bind_int(insertStatement,1,Int32(empId)) != SQLITE_OK{
                print(String(cString: sqlite3_errmsg(db)))
            }
            
            if sqlite3_bind_text(insertStatement,
                               2,
                               ((empName as NSString).utf8String),
                               -1,
                                 nil) != SQLITE_OK{
                print(String(cString: sqlite3_errmsg(db)))
            }

            if sqlite3_bind_double(insertStatement,3,empSalary) == SQLITE_OK{
                print(String(cString: sqlite3_errmsg(db)))
            }
            
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("insertion successful")
            }else{
                print(String(cString: sqlite3_errmsg(db)))
                print("insertion unsuccessful")
            }
        }else{
            print(String(cString: sqlite3_errmsg(db)))
            print("insert query statement unsuccessfull")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func retriveEmployee() -> [Employee] {
        
        let retriveQueryString = "SELECT * FROM Employee;"
        var retriveStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db,
                              retriveQueryString,
                              -1,
                              &retriveStatement,
                              nil) == SQLITE_OK{
            print("Retrive Query String Preparation Successfull")
            
            while(sqlite3_step(retriveStatement) == SQLITE_ROW){
                
                let extractedEmpId = Int(sqlite3_column_int(retriveStatement, 0))
                let extractedEmployeeName = String(cString:sqlite3_column_text(retriveStatement, 1))
                let extractedEmployeeSalary = (sqlite3_column_double(retriveStatement, 2))
                
                let newEmpObject = Employee(employeeId: extractedEmpId,
                                            employeeName: extractedEmployeeName,
                                            employeeSalary: extractedEmployeeSalary)
                
                self.employees.append(newEmpObject)
            }
            
        }else{
            print(String(cString: sqlite3_errmsg(db)))
        }
        
        return employees
    }
}
