//
//  DBConnector.swift
//
//  Created by Dhirendra Verma on 10/04/19.
//

import RealmSwift

class DBConnector {
    private let db:Realm
    static let connect = DBConnector()
    
    private init() {
        db = try! Realm()
    }
    
    func read() -> Results<GitHubRepoModel> {
        return db.objects(GitHubRepoModel.self)
    }
    
    func create(values:[GitHubRepoModel]) {
        self.add(values: values)
    }
    
    func create(value: GitHubRepoModel) {
        self.add(values: [value])
    }
    
    func clearDB()  {
        try! db.write {
            db.deleteAll()
        }
    }
    func removeObject(value: GitHubRepoModel)   {
        try! db.write {
            db.delete(value)
        }
    }
    
    private func add(values: [GitHubRepoModel], update: Bool = true){
        try! db.write {
            db.add(values, update: true)
        }
    }
    
}

