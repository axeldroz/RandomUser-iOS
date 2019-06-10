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
    var fetchingMore = false
    
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
        self.fetchUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // uncomment this line if you want the suggested users reload each time you go back to the view
        //fetchUsers()
    }
    
    func reload() {
        self.tableView.reloadData()
    }
    
    func fetchUsers(_ reload: Bool = true, success: (([UserModel]) -> Void)? = nil, error: ((Int, String) -> Void)? = nil) {
        apiService.fetchUsers(number: 10, page: 1, success: { models in
            if (reload) {
                self.models = models
                if self.models.count > 0 {
                    self.reload()
                }
            }
            if let cb = success {
                cb(models)
            }
        }, error : { code, body in
            if let cb = error {
                cb(code, body)
            }
        })
    }
    
    @objc func refresh (_ refreshControl: UIRefreshControl) {
        fetchUsers(success: { models in
            self.refreshControl.endRefreshing()
        }, error: { _,_ in })
    }
    
    func addFriendToLocalDB(id: Int, userModel: UserModel, username: String) {
        let friend = Friend()
        //let picture = Picture()
        guard let uuid = userModel.login?.uuid else {
            print ("user with the same uuid has already been added")
            return
        }
        /*friend.firstname = userModel.name?.first ?? "unknown"
        friend.lastname = userModel.name?.last ?? "unknown"
        friend.email = userModel.email ?? "unknown"
        friend.username = username
        friend.id = id
        friend.title = userModel.name?.title ?? "unknown"
        friend.gender = userModel.gender ?? "unknown"
        picture.id = friend.id
        picture.thumbail = userModel.picture?.thumbail ?? ""
        picture.medium = userModel.picture?.medium ?? ""
        picture.large = userModel.picture?.large ?? ""
        friend.picture = picture
        friend.uuid = uuid
        friend.phone = userModel.phone*/
        
        friend.fromModel(model: userModel, id: id)
        
        do {
            try defRealm.write({ () -> Void in
                defRealm.add(friend)
            })
        } catch (let e) {
            print("Realm exception : ", e.localizedDescription)
        }
    }
    
    func userExists(username: String) -> Bool {
        let friends = defRealm.objects(Friend.self)
        var nb = 0
        
        if (username == "") {
            return false
        }
        if friends.count > 0 {
            let predicate = NSPredicate(format: "username = %@", username)
            nb = defRealm.objects(Friend.self).filter(predicate).count
        }
        return nb > 0;
    }
    
    func fetchMore() {
        fetchingMore = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.fetchUsers(false, success: { newItems in
                /*for item in newItems {
                    self.models.append(item)
                }*/
                self.models.append(contentsOf: newItems)
                self.reload()
                self.fetchingMore = false
            }, error: { _,_ in })
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileVC" {
            if let vc = segue.destination as? ProfileVC {
                if let index = sender as? Int {
                    let model = self.models[index]
                    let viewModel = UserProfileViewModel(model: model)
                    vc.viewModel = viewModel
                } else {
                    print("Error while giving the viewModel to the ProfileVC ViewController")
                }
            }
        }
    }

}

extension UsersListVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.models.count
        } else if section == 1 && fetchingMore {
            return 1
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UsersListCell
            let model = self.models[indexPath.row]
            let viewModel = UserCellViewModel(model: model)
            let image = UIImage(named: "ic-add")
            let addImageView = UIImageView(image: image)
            let tap = UITapGestureRecognizer(target: self, action: #selector(addTapped))
            addImageView.isUserInteractionEnabled = true
            addImageView.addGestureRecognizer(tap)
            addImageView.tag = indexPath.row
            cell.accessoryView = addImageView
        
            if (self.userExists(username: model.login?.username ?? "")) {
                addImageView.isHidden = true
            }
            cell.viewModel = viewModel
            cell.backgroundColor = .clear
            return cell as UITableViewCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "activityIndicator", for: indexPath) as! LoadingCell
            cell.spinner.startAnimating()
            return cell
        }
    }
    
    @objc func addTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let view = tapGestureRecognizer.view as? UIImageView
        let friends = defRealm.objects(Friend.self)
        
        guard let index = view?.tag else {
            print("Error guard index")
            return
        }
        let userModel = self.models[index]
        guard let username = userModel.login?.username else {
            print("Error guard username")
            return
        }
        view?.isHidden = true
        if (!userExists(username: username)) {
            self.addFriendToLocalDB(id: friends.count, userModel: userModel, username: username)
        } else {
            print ("user already exists")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 82
        } else if indexPath.section == 1 && fetchingMore {
            return 44
        }
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height + 20 {
            if !fetchingMore {
                self.fetchMore()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            self.performSegue(withIdentifier: "profileVC", sender: indexPath.row)
        }
    }
}

