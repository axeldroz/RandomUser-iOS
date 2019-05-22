//
//  UsersListVC.swift
//  SwapcardChallenge
//
//  Created by Axel Drozdzynski on 13/05/2019.
//  Copyright © 2019 Axel Droz. All rights reserved.
//

import UIKit

class UsersListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var models = [UserModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem?.tintColor = UIHelper.Color.whiteColor
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: view.frame.height))
        titleLabel.text = "Users"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
        UIHelper.loadNavigationBarStyle(self.navigationController!)
        self.tableView.backgroundColor = .clear
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apiService.fetchUsers(vc: self)
    }
    
    func reload() {
        self.tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UsersListVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UITableViewCell
        //let feedImageModel = FeedImageModel(id: 1, authorName: nil, postedAt: nil, location: nil, title: nil, description: nil, priceExcT: nil, priceIT: nil, rating: nil, path: "https://blobpictaliodev.blob.core.windows.net/images/d42c1ee3-8bf2-4d5f-8805-8ec614505d58.jpg")
        //let feedImageVM = FeedImageViewModel(model: imageModels[indexPath.row])
        //cell.viewModel = feedImageVM
        //cell.backgroundColor = .clear
        return cell as UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
}

