//
//  DBWrapper.swift
//  todoPOOJA
//
//  Created by Student-12 on 07/10/19.
//  Copyright © 2019 felix. All rights reserved.
//

import UIKit
import SQLite3

class DBWrapper: NSObject {
    
    static let sharedobject = DBWrapper()
    
    var EmpId = [String]()
    var EmpName = [String]()
    
    func getDatabasePath() -> String
    {
        
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let path = docDir.first
        
        return path! + "myEmpDatabase.sqlite"
        
    }
    
    func executeQuery(query:String) -> Bool
    {
        var success = false
        var db: OpaquePointer?
        var stmt: OpaquePointer?
        let databasePath = getDatabasePath()
        
        
        
        if(sqlite3_open(databasePath, &db) == SQLITE_OK)
        {
            if(sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK)
            {
                if(sqlite3_step(stmt) == SQLITE_DONE)
                {
                    success = true
                    sqlite3_finalize(stmt)
                    sqlite3_close(db!)
                    
                    
                    
                }
                
            }
            
            
        }
        
        else
        {
            print("Error in Opening Database\(sqlite3_errmsg(db))")
        }
        
        return success
        
    }
    
   
    func SelectAllTask(query:String)->Array<Any>
    {
        EmpId = [String]()
        EmpName = [String]()
        
        
        var db:OpaquePointer?
        var stmt:OpaquePointer?
        let databsePath = getDatabasePath()
        
        
            if(sqlite3_open(databsePath, &db) == SQLITE_OK)
            {
                if(sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK)
                {
                    
                    while(sqlite3_step(stmt) == SQLITE_ROW)
                    {
                        let idText = sqlite3_column_text(stmt, 0)
                        let nameText = sqlite3_column_text(stmt, 1)
                        
                        
                        let idString = String(cString:idText!)
                        let nameString = String(cString:nameText!)
                        
                        EmpId.append(idString)
                        EmpName.append(nameString)
                        
                        print(EmpId)
                        print(EmpName)
                        
                        
                        sqlite3_close(db!)
                    }
                }
                
        }
        else
            {
                print("Error in Database..\(sqlite3_errmsg(db!))")
        }
        
        return EmpName
        
        
        
    }
    
    
    
    
    
    func createTable()
    {
        
        let createQuery = "create table if not exists Employee(EmpId text,EmpName text)"
        
        let isSuccess = executeQuery(query: createQuery)
        
        
        if(isSuccess)
        {
            print("Table Created Successfully..")
        }
        else
        {
            print("Table Not  Created..")
        }
        
    
    }
    
    
    

}
