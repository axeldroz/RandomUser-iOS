//
//  UsersListVC.swift
//  SwapcardChallenge
//
//  Created by Axel Drozdzynski on 13/05/2019.
//  Copyright © 2019 Axel Drozdzynski. All rights reserved.
//

import UIKit
import RealmSwift

class UsersListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var models = [UserModel]()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
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
        self.tableView.addSubview(self.refreshControl)
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
    
    @objc func refresh (_ refreshControl: UIRefreshControl) {
        apiService.fetchUsers(vc: self)
        self.refreshControl.endRefreshing()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UsersListCell
        let viewModel = UserViewModel(model: self.models[indexPath.row])
        let image = UIImage(named: "ic-add")
        let addImageView = UIImageView(image: image)
        let tap = UITapGestureRecognizer(target: self, action: #selector(addTapped))
        addImageView.isUserInteractionEnabled = true
        addImageView.addGestureRecognizer(tap)
        addImageView.tag = indexPath.row
        cell.accessoryView = addImageView
        cell.viewModel = viewModel
        cell.backgroundColor = .clear
        return cell as UITableViewCell
    }
    
    @objc func addTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let view = tapGestureRecognizer.view as? UIImageView
        print("ok")
        view?.isHidden = true
        // add to db local
        guard let index = view?.tag else {
            print("Error guard index")
            return
        }
        let userModel = self.models[index]
        print("userMode :", userModel)
        guard let username = userModel.login?.username else {
            print("Error guard username")
            return
        }
        let friends = defRealm.objects(Friend.self)
        var nb = 0
        

        
        if friends.count > 0 {
            print("IF 1")
            let predicate = NSPredicate(format: "username = %@", username)
            let nb = defRealm.objects(Friend.self).filter(predicate).count
        }
        if (nb <= 0) {
            print("IF 2")
            if (nb <= 0) {
                let friend = Friend()
                let picture = Picture()
                friend.firstname = userModel.name?.first ?? "unknown"
                friend.lastname = userModel.name?.last ?? "unknown"
                friend.email = userModel.email ?? "unknown"
                friend.username = username
                friend.id = friends.count
                friend.title = userModel.name?.title ?? "unknown"
                friend.gender = userModel.gender ?? "unknown"
                picture.id = friend.id
                picture.thumbail = userModel.picture?.thumbail ?? ""
                picture.medium = userModel.picture?.medium ?? ""
                picture.large = userModel.picture?.large ?? ""
                friend.picture = picture
                do {
                    try defRealm.write({ () -> Void in
                        defRealm.add(friend)
                    })
                } catch (let e) {
                    print("Realm exception : ", e.localizedDescription)
                }
            }
        } else {
            print ("user already exists")
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
}

