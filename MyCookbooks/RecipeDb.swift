//
//  RecipeDb.swift
//  MyCookbooks
//
//  Created by Russ Perlow on 4/30/20.
//  Copyright © 2020 Russ Perlow. All rights reserved.
//

import Foundation
import SQLite3

class RecipeDb {

    
    static let sharedInstance: RecipeDb = {
        let instance = RecipeDb()
        instance.createDb()
        return instance
    }()
    
    var db: OpaquePointer?
    var fileURL: URL?;
    var recipeList = [Recipe]()

    private func createDb(){
        fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                 .appendingPathComponent("recipe.sqlite")
        
        if sqlite3_open(fileURL?.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS recipes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, ingredients TEXT, steps TEXT, image TEXT)", nil, nil, nil) != SQLITE_OK {
            sqlError(specific: "creating table")
        }
    }

    func insertRecipe(title: String, ingredients: String, steps: String, image: String){
        var stmt: OpaquePointer?
        let queryString = "INSERT INTO recipes (title, ingredients, steps, image) VALUES (?,?,?,?)"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            sqlError(specific: "preparing insert")
            return
        }
        
        if sqlite3_bind_text(stmt, 1, title, -1, nil) != SQLITE_OK{
            sqlError(specific: "binding title")
            return
        }
        
        if sqlite3_bind_text(stmt, 2, ingredients, -1, nil) != SQLITE_OK{
            sqlError(specific: "binding ingredients")
            return
        }
        
        if sqlite3_bind_text(stmt, 3, steps, -1, nil) != SQLITE_OK{
            sqlError(specific: "binding steps")
            return
        }
        
        if sqlite3_bind_text(stmt, 4, image, -1, nil) != SQLITE_OK{
            sqlError(specific: "binding image")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            sqlError(specific: "inserting recipe")
            return
        }
        
    }
    
    func deleteRecipe(id: Int){
        var stmt: OpaquePointer?
        let queryString = "DELETE FROM recipes WHERE id = ?"
        
        if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            sqlError(specific: "preparing deletion for \(id)")
            return
        }
        
        if sqlite3_bind_int(stmt, 1, Int32(id)) != SQLITE_DONE {
            sqlError(specific: "binding deletion for \(id)")
            return
        }
        
        sqlite3_finalize(stmt)
        
    }

    func readValues(){
        recipeList.removeAll()
        
        let queryString = "SELECT * FROM recipes"
        
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            sqlError(specific: "preparing insert in read")
            return
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let title = String(cString: sqlite3_column_text(stmt, 1))
            let ingredients = String(cString: sqlite3_column_text(stmt, 2))
            let steps = String(cString: sqlite3_column_text(stmt, 3))
            let image = String(cString: sqlite3_column_text(stmt, 4))
            
            recipeList.append(Recipe(id: id, title: title, ingredients: ingredients, steps: steps, image: image))
        }
        
    }

    private func sqlError(specific: String){
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("sql error \(specific) \(errmsg)")
    }
}
