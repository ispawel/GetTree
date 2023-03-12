//
//  GetTree.swift
//  
//
//  Created by Pavel Isakov on 13.02.2023.
//

import Foundation

//  [ ] Catalog
//  ... [ ] Films
//  ... ... [ ] Fantasy
//  ... ... [ ] Horror
//  ... ... ... [ ] 50x
//  ... ... ... [ ] 60x
//  ... ... ... [ ] 70x
//  ... ... ...  * 70x Horror Film
//  ... ... ... [ ] 80x
//  ... ... ... [ ] 90x
//  ... ... [ ] Comedy
//  ...  * Film 1
//  ... [ ] Music
//  ... ... [ ] Pop
//  ... ...  * Pop Album 1
//  ... ...  * Pop Album 2
//  ... ...  * Pop Album 3
//  ... ... [ ] Rock
//  ... ... ... [ ] Hard Rock
//  ... ... ... [ ] Heavy Metal
//  ... ... ...  * Heavy Metal Album 1
//  ... ... ... [ ] Alternative
//  ... ...  * Rock Album 1
//  ... ...  * Rock Album 2
//  ... ... [ ] Jazz
//  ...  * Music Album 1


// MARK: - Types
class Item {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class Category {
    let name: String
    let childs: [Category]
    let items: [Item]
    
    init(name: String, childs: [Category] = [], items: [Item] = []) {
        self.name = name
        self.childs = childs
        self.items = items
    }
}

// MARK: - Initialize

let filmCategory = Category(name: "Films",
                            childs: [.init(name: "Fantasy"),
                                     .init(name: "Horror",
                                           childs: [.init(name: "50x"),
                                                    .init(name: "60x"),
                                                    .init(name: "70x",
                                                          items: [.init(name: "70x Horror Film")]),
                                                    .init(name: "80x"),
                                                    .init(name: "90x")]),
                                     .init(name: "Comedy")],
                            items: [.init(name: "Film 1")])

let musicCategory = Category(name: "Music",
                             childs: [
                                .init(name: "Pop",
                                      items: [.init(name: "Pop Album 1"),
                                              .init(name: "Pop Album 2"),
                                              .init(name: "Pop Album 3")]),
                                .init(name: "Rock",
                                      childs: [.init(name: "Hard Rock"),
                                               .init(name: "Heavy Metal",
                                                     items: [.init(name: "Heavy Metal Album 1")]),
                                               .init(name: "Alternative")],
                                      items: [.init(name: "Rock Album 1"),
                                              .init(name: "Rock Album 2")]),
                                .init(name: "Jazz")],
                             items: [.init(name: "Music Album 1")])

let mainCategory = Category(name: "Catalog", childs: [filmCategory, musicCategory])


// MARK: - Functions

// 1 Get all items and folders
func getAll(category: Category) -> [String] {
    
    var result: [String] = []
    var counLevel = ""
    
    getStruct(category: category, level: 0)
    
    func getStruct(category: Category, level: Int){
        
        counLevel = String(repeating: "... ", count: level)
        result += ["\(counLevel)[ ] \(category.name)"]
        
        for child in category.childs {
            getStruct(category: child, level: level + 1)
        }
        
        counLevel = String(repeating: "... ", count: level)
        
        for item in category.items {
            result += ["\(counLevel) * \(item.name)"]
        }
    }
    
    if result.isEmpty {
        result.insert("--- EMPTY ----------------", at: 0)
    } else {
        result.insert("-- NOT EMPTY -------------", at: 0)
    }
    return result
    
}

// 2 get folders only whith items
func getChildsWithItems(category: Category) -> [String] {
    
    var result: [String] = []
    var counLevel = ""
    
    getStruct(category: category, level: 0)
    
    func getStruct(category: Category, level: Int){
        
        // если есть файлы
        if category.items.count > 0 {
            
            counLevel = String(repeating: "... ", count: level)
            result += ["\(counLevel)[ ] \(category.name)"]
            
            if category.childs.count > 0 {
                for child in category.childs {
                    getStruct(category: child, level: level + 1)
                }
            }
        
        // если нет файлов
        } else {
            if category.childs.count > 0 {
                
                counLevel = String(repeating: "... ", count: level)
                result += ["\(counLevel)[ ] \(category.name)"]
                
                for child in category.childs {
                    getStruct(category: child, level: level + 1)
                }
            }
        }
        
        counLevel = String(repeating: "... ", count: level)
        
        for item in category.items {
            result += ["\(counLevel) * \(item.name)"]
        }
    }
    
    if result.isEmpty {
        result.insert("-------- EMPTY ---------", at: 0)
    } else {
        result.insert("------ NOT EMPTY -------", at: 0)
    }
    return result
}


// Call
let results = getAll(category: mainCategory)
//let results = getChildsWithItems(category: mainCategory)

results.map{ print($0) }
