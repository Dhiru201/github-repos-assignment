//
//  GitHubRepoModel.swift
//  Assignment
//
//  Created by Dhirendra Verma on 10/04/19.
//  Copyright © 2019 ispro. All rights reserved.
//

import Foundation


class GitHubRepoViewModel : NSObject{
	
	static func getData(pageNumber:Int, callback: @escaping (_ response:[GitHubRepoModel],_ error:Error?)-> Void){
		if APIManager.shared.getReachabilityStatus() == .reachable{
			self.apiCallForData(pageNumber: pageNumber, callback: callback)
		}else{
			self.fetchDataOffline(pageNumber: pageNumber, callback: callback)
		}
	}
	
	private static func fetchDataOffline(pageNumber:Int, callback: @escaping (_ response:[GitHubRepoModel],_ error:Error?)-> Void){
        let data = DBConnector.connect.read().filter("pageNumber = \(pageNumber)")
        callback(Array(data), nil)
		
	}
    
    private static func saveOfflineData(data: [GitHubRepoModel]){
        DBConnector.connect.create(values: data)
    }
	
	private static func apiCallForData(pageNumber:Int, callback: @escaping (_ response:[GitHubRepoModel],_ error:Error?)-> Void){
		APIManager.shared.fetchDataFromUrl(Constants.url(pageNumber: pageNumber, perPageCount: 15)) { (data,error)  in
			if error != nil{
				callback([], error)
			}else{
				var reposArr = [GitHubRepoModel]()
				guard let dataArr = data else{
					callback([], nil)
					return
				}
					for object in dataArr{
                        reposArr.append(GitHubRepoModel(dictionary: object, pageNumber: pageNumber)!)
					}
					callback(reposArr, nil)
                    saveOfflineData(data: reposArr)
			}
		}
	}

}
