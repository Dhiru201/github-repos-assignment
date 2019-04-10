//
//  APIManager.swift
//  Assignment
//
//  Created by Dhirendra Verma on 10/04/19.
//  Copyright © 2019 ispro. All rights reserved.
//

import Foundation
import Alamofire


class APIManager{
	
	static let shared = APIManager()
	
	enum ReachabilityStatus {
		case reachable
		case notReachable
	}
	
	func getReachabilityStatus() -> ReachabilityStatus {
		let reachabilityManager = NetworkReachabilityManager()
		if (reachabilityManager?.isReachable)! {
			return .reachable
		}
		else{
			return .notReachable
		}
	}
	
	func fetchDataFromUrl(_ url:String,callback:@escaping ([[String:Any]]?, _ error: Error?)->Void) {
		Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (response) in
			switch response.result {
			case .success :
				if let data = response.result.value as? [[String:Any]]{
					callback(data, nil)
				}else{
					callback([], nil)
				}
			case .failure :
				callback([], response.error)
			}
		}
	}
}
