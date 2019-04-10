//
//  GitHubRepoTableCell.swift
//  Assignment
//
//  Created by Dhirendra Verma on 10/04/19.
//  Copyright © 2019 ispro. All rights reserved.
//

import UIKit

class GitHubRepoTableCell: UITableViewCell {

	@IBOutlet var languageStack: UIStackView!
	@IBOutlet var lbl_Watchers: UILabel!
	@IBOutlet var lbl_OpenIssues: UILabel!
	@IBOutlet var lbl_Description: UILabel!
	@IBOutlet var lbl_Language: UILabel!
	@IBOutlet var lbl_Title: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func configureRepoCell(data:GitHubRepoModel){
		self.lbl_Title.text = data.name
		if data.language != ""{
			self.lbl_Language.text = data.language
		}else{
			languageStack.isHidden = true
		}
		
        self.lbl_Watchers.text = "\(data.watchers)"
        self.lbl_OpenIssues.text = "\(data.openIssues)"
		self.lbl_Description.text = data.descriptionField
	}
}
