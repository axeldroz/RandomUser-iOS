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
        self.fetchUsers(success : nil, error : { [weak self] code, body in
            let alertVC = UIAlertController(title: "Error", message: "Connection with server failed", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            }))
            self?.present(alertVC, animated: true, completion: nil)
        })
    }
    
    func reload() {
        self.tableView.reloadData()
    }
    
    func fetchUsers(_ reload: Bool = true, success: (([UserModel]) -> Void)? = nil, error: ((Int, String) -> Void)? = nil) {
        apiService.fetchUsers(number: 10, page: 1, success: { [weak self] models in
            if (reload) {
                self?.models = models
                if ((self?.models.count ?? 0) > 0) {
                    self?.reload()
                }
            }
            success?(models)
        }, error : { code, body in
            error?(code, body)
        })
    }
    
    @objc func refresh (_ refreshControl: UIRefreshControl) {
        fetchUsers(success: { [weak self] models in
            self?.refreshControl.endRefreshing()
        }, error: { [weak self] code, body in
            let alertVC = UIAlertController(title: "Error", message: "Connection with server failed", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            }))
            self?.present(alertVC, animated: true, completion: nil)
            self?.refreshControl.endRefreshing()
        })
    }
    
    func addFriendToLocalDB(userModel: UserModel) {
        let friend = Friend()
        let friends = defRealm.objects(Friend.self)
        let pictures = defRealm.objects(Picture.self)
        
        let pictureId = (pictures.last != nil) ? pictures.last!.id + 1 : 0
        friend.fromModel(model: userModel, pictureId: pictureId)
        do {
            try defRealm.write({ () -> Void in
                defRealm.add(friend)
            })
        } catch (let e) {
            print("Realm exception : ", e.localizedDescription)
        }
    }
    
    /*
     * Called from ProfileVC
     */
    func addFriendToLocalDB(index: Int) {
        let friend = Friend()
        let pictures = defRealm.objects(Picture.self)
        let userModel = self.models[index]
        
        let pictureId = (pictures.last != nil) ? pictures.last!.id + 1 : 0
        friend.fromModel(model: userModel, pictureId: pictureId)
        do {
            try defRealm.write({ () -> Void in
                defRealm.add(friend)
            })
            let cell = self.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! UsersListCell
            cell.accessoryView?.isHidden = true
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.fetchUsers(false, success: { [weak self] newItems in
                self?.models.append(contentsOf: newItems)
                self?.reload()
                self?.fetchingMore = false
            }, error: { [weak self] _,_ in
                self?.fetchingMore = false
            })
        }
    }

    // Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileVC" {
            if let vc = segue.destination as? ProfileVC {
                if let index = sender as? Int {
                    let model = self.models[index]
                    let exists = self.userExists(username: model.login?.username ?? "")
                    let viewModel = UserProfileViewModel(model: model, exists: exists)
                    vc.viewModel = viewModel
                    vc.usersListVC = self
                    vc.index = index
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
            addImageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
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
            self.addFriendToLocalDB(userModel: userModel)
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

