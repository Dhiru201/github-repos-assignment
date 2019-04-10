//
//  OfflineDataStorageTest.swift
//  AssignmentTests
//
//  Created by Dhirendra Verma on 10/04/19.
//  Copyright © 2019 ispro. All rights reserved.
//

import XCTest
@testable import Assignment

class OfflineDataStorageTest: XCTestCase {

    override func setUp() {
        DBConnector.connect.clearDB()
        DBConnector.connect.create(values: self.getFixtureData())
    }

    override func tearDown() {
        DBConnector.connect.clearDB()
    }

    func testAllEntriesShouldBeSavedInLocalDB() {
        XCTAssertEqual(self.getFixtureData().count, 15)
        XCTAssertEqual(DBConnector.connect.read().count, self.getFixtureData().count)
    }
    
    func testOfflineDataShouldReturnPageWiseData(){
        
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func getFixtureData() -> [GitHubRepoModel]{
        var gitHubRepos = [GitHubRepoModel]()
        if let path = Bundle.main.path(forResource: "repo", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, Any> {
                    let repos = jsonResult["data"] as! [[String: Any]]
                    for repo in repos{
                        gitHubRepos.append(GitHubRepoModel(dictionary: repo, pageNumber: 1)!)
                    }
                    
                    
                }
            } catch {
                print("Some Error")
            }
        }
        return gitHubRepos
    }

}
