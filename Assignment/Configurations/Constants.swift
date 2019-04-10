//
//  Constants.swift
//  Assignment
//
//  Created by Dhirendra Verma on 10/04/19.
//  Copyright © 2019 ispro. All rights reserved.
//

struct Constants {
	
	static let gitHubRepoTableCellId = "GITHUBREPOTABLECELL"
	
	static func url(pageNumber:Int, perPageCount:Int = 15) -> String{
		let mainUrl = "https://api.github.com/users/JakeWharton/repos?page=\(pageNumber)&per_page=\(perPageCount)"
		return mainUrl
	}
}

