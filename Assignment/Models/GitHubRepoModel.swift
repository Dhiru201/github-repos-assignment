//
//  GitHubRepoModel.swift
//  Assignment
//
//  Created by Dhirendra Verma on 10/04/19.
//  Copyright © 2019 ispro. All rights reserved.
//

import RealmSwift

class GitHubRepoModel:Object{
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var descriptionField = ""
    @objc dynamic var language = ""
    @objc dynamic var openIssues = 0
    @objc dynamic var watchers = 0
    @objc dynamic var pageNumber = 1
    
    required convenience init?(dictionary: [String:Any], pageNumber: Int) {
        self.init()
        self.id = dictionary["id"] as? Int ?? self.id
        self.name = dictionary["name"] as? String ?? self.name
        self.descriptionField = dictionary["description"] as? String ?? self.descriptionField
        self.language = dictionary["language"] as? String ?? self.language
        self.openIssues = dictionary["open_issues"] as? Int ?? self.openIssues
        self.watchers = dictionary["watchers"] as? Int ?? self.watchers
        self.pageNumber = pageNumber
    }
    
   
    
    override static func primaryKey()->String?{
        return "id"
    }
}
