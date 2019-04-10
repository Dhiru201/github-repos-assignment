//
//  GitHubRepoVC.swift
//  Assignment
//
//  Created by Dhirendra Verma on 10/04/19.
//  Copyright © 2019 ispro. All rights reserved.
//

import UIKit

class GitHubRepoVC: UIViewController {
	@IBOutlet var headerTitle: UILabel!
	@IBOutlet var headerView: UIView!
	@IBOutlet var GitHubRepoTable: UITableView!
    
	var dataArray = [GitHubRepoModel]()
	var pageNumber = 1
	var footerView:UIView!
    var isDataCompleted = false
	
	override func viewDidLoad() {
        super.viewDidLoad()
		self.configureGitHubRepoTable()
    }

	func configureGitHubRepoTable(){
		self.GitHubRepoTable.delegate = self
		self.GitHubRepoTable.dataSource = self
		self.fetchData(pageNumber: pageNumber)
        self.GitHubRepoTable.tableFooterView?.isHidden = true
        
	}
	
	func fetchData(pageNumber:Int){
        if self.isDataCompleted == true{
            return
        }
        self.GitHubRepoTable.tableFooterView?.isHidden = false
        GitHubRepoViewModel.getData(pageNumber: pageNumber) { (data, error) in
			if error != nil{
                print(error?.localizedDescription as Any)
                self.alert(msg: error!.localizedDescription, title: "Error!")
            }else{
				if data.count > 0{
					for object in data{
						self.dataArray.append(object)
					}
                    self.GitHubRepoTable.tableFooterView?.isHidden = true
                    DispatchQueue.main.async {
                        self.GitHubRepoTable.reloadData()
                    }
					
				}else{
                    self.GitHubRepoTable.tableFooterView?.isHidden = true
                    self.isDataCompleted = true
				}
			}
		}
	}
    
    func alert(msg:String, title:String){
        let alert = UIAlertController(title: title, message:msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in}
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }

}


extension GitHubRepoVC: UITableViewDelegate{
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if indexPath.item == dataArray.count - 3{
			pageNumber = pageNumber + 1
			self.fetchData(pageNumber: pageNumber)
            tableView.tableFooterView?.isHidden = false
            }
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            // print("this is the last cell")
            let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            self.GitHubRepoTable.tableFooterView = spinner
            self.GitHubRepoTable.tableFooterView?.isHidden = false
        }
	}
}

extension GitHubRepoVC:UITableViewDataSource{
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 110
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataArray.count
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Constants.gitHubRepoTableCellId, for: indexPath) as! GitHubRepoTableCell
		let dataObject = dataArray[indexPath.item]
		cell.configureRepoCell(data: dataObject)
		return cell
	}
	
	
	
}
