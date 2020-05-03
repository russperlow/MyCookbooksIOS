//
//  CocktailDb.swift
//  MyCookbooks
//
//  Copyright © 2020 Russ Perlow. All rights reserved.
//

import Foundation
import SQLite3

class CocktailDb {

    
    static let sharedInstance: CocktailDb = {
        let instance = CocktailDb()
        instance.createDb()
        return instance
    }()
    
    var db: OpaquePointer?
    var fileURL: URL?;
    var cocktailList = [Cocktail]()

    private func createDb(){
        fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                 .appendingPathComponent("cocktail.sqlite")
        
        if sqlite3_open(fileURL?.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS cocktails (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, ingredients TEXT, image TEXT)", nil, nil, nil) != SQLITE_OK {
            sqlError(specific: "creating table")
        }
    }

    func insertCocktail(title: String, ingredients: String, image: String){
        var stmt: OpaquePointer?
        let queryString = "INSERT INTO cocktails (title, ingredients, image) VALUES (?,?,?)"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            sqlError(specific: "preparing insert")
            return
        }
        
        if sqlite3_bind_text(stmt, 1, NSString(string: title).utf8String, -1, nil) != SQLITE_OK{
            sqlError(specific: "binding title")
            return
        }
        
        if sqlite3_bind_text(stmt, 2, NSString(string: ingredients).utf8String, -1, nil) != SQLITE_OK{
            sqlError(specific: "binding ingredients")
            return
        }
        
        if sqlite3_bind_text(stmt, 3, NSString(string: image).utf8String, -1, nil) != SQLITE_OK{
            sqlError(specific: "binding image")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            sqlError(specific: "inserting cocktail")
            return
        }
        
    }
    
    func deleteCocktail(id: Int){
        var stmt: OpaquePointer?
        let queryString = "DELETE FROM cocktails WHERE id = ?"
        
        if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            sqlError(specific: "preparing deletion for \(id)")
            return
        }
        
        sqlite3_bind_int(stmt, 1, Int32(id))
        if sqlite3_step(stmt) != SQLITE_DONE {
            sqlError(specific: "binding deletion for \(id)")
            return
        }
        
        sqlite3_finalize(stmt)
        
    }

    func readValues(){
        cocktailList.removeAll()
        
        let queryString = "SELECT * FROM cocktails"
        
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            sqlError(specific: "preparing insert in read")
            return
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let title = String(cString: sqlite3_column_text(stmt, 1))
            let ingredients = String(cString: sqlite3_column_text(stmt, 2))
            let image = String(cString: sqlite3_column_text(stmt, 3))
            
            cocktailList.append(Cocktail(id: id, title: title, ingredients: ingredients, image: image))
        }
        
    }

    private func sqlError(specific: String){
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("sql error \(specific) \(errmsg)")
    }
}
