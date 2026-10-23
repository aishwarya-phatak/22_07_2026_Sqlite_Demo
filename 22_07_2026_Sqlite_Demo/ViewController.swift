//
//  ViewController.swift
//  22_07_2026_Sqlite_Demo
//
//  Created by Vishal Jagtap on 14/10/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        DBHelper.shared.insertDataIntoTable(empId: 123, empName: "Mayur", empSalary: 34523.21)
//        DBHelper.shared.insertDataIntoTable(empId: 124, empName: "Omkar", empSalary: 34523.21)
//        DBHelper.shared.insertDataIntoTable(empId: 125, empName: "Kirti", empSalary: 34523.21)
//        DBHelper.shared.insertDataIntoTable(empId: 126, empName: "Raj", empSalary: 34523.21)
//        DBHelper.shared.insertDataIntoTable(empId: 127, empName: "Swapnali", empSalary: 34523.21)
        
        
//          DBHelper.shared.insertDataIntoTable(empId: 223, empName: "Mayur", empSalary: 34523.21)
//          DBHelper.shared.insertDataIntoTable(empId: 224, empName: "Omkar", empSalary: 34523.21)
//          DBHelper.shared.insertDataIntoTable(empId: 225, empName: "Kirti", empSalary: 34523.21)
//          DBHelper.shared.insertDataIntoTable(empId: 226, empName: "Raj", empSalary: 34523.21)
//          DBHelper.shared.insertDataIntoTable(empId: 227, empName: "Swapnali", empSalary: 34523.21)
        
//        var employees = DBHelper.shared.retriveEmployee()
//        
//        for eachEmp in employees{
//            print(eachEmp)
//        }
        
//        DBHelper.shared.deleteEmployeeRecord(empId: 225)
        
        print("-------------after deletion----------------")
        
        var employees = DBHelper.shared.retriveEmployee()
        for eachEmp in employees{
            print(eachEmp)
        }
        
        DBHelper.shared.updateEmployeeRecord(empId: 223, newEmpName: "Yash", newEmpSalary: 345234.23)
        print("-------------after update----------------")
        employees = DBHelper.shared.retriveEmployee()
        for eachEmp in employees{
            print(eachEmp)
        }
    }
}
