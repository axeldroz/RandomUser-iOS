//
//  FavorisVC.swift
//  
//
//  Created by Axel Drozdzynski on 26/05/2019.
//

import UIKit
import RealmSwift

class FavorisVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var models : Results<Friend>!
    
    /*lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }()*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem?.tintColor = UIHelper.Color.whiteColor
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: view.frame.height))
        titleLabel.text = "Favoris"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
        UIHelper.loadNavigationBarStyle(self.navigationController!)
        self.tableView.backgroundColor = .clear
        self.tableView.delegate = self
        self.tableView.dataSource = self
        getFavoris()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavoris()
        reload()
        //apiService.fetchUsers2(vc: self)
    }
    
    private func getFavoris() {
        self.models = defRealm.objects(Friend.self)
    }
    
    func reload() {
        self.tableView.reloadData()
    }
    
    /*@objc func refresh (_ refreshControl: UIRefreshControl) {
        getFavoris()
        reload()
        self.refreshControl.endRefreshing()
    }*/
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension FavorisVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UsersListCell
        let viewModel = UserViewModel(model: self.models[indexPath.row])
        let image = UIImage(named: "ic-trash")
        let addImageView = UIImageView(image: image)
        let tap = UITapGestureRecognizer(target: self, action: #selector(removeTapped))
        addImageView.isUserInteractionEnabled = true
        addImageView.addGestureRecognizer(tap)
        addImageView.tag = indexPath.row
        cell.accessoryView = addImageView
        cell.viewModel = viewModel
        cell.backgroundColor = .clear
        return cell as UITableViewCell
    }
    
    @objc func removeTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let view = tapGestureRecognizer.view as? UIImageView
        view?.isHidden = true
        // add to db local
        guard let index = view?.tag else {
            print("Error guard index")
            return
        }
        let friend = self.models[index]
        print("fiend :", friend)

        do {
            try defRealm.write {
                if let pic = friend.picture {
                    defRealm.delete(pic)
                }
                defRealm.delete(friend)
            }
        } catch (let ex) {
            print("ex : ", ex.localizedDescription)
        }
        self.getFavoris()
        self.reload()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
}


