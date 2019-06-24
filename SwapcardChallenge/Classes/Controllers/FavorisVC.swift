//
//  FavorisVC.swift
//  
//
//  Created by Axel Drozdzynski on 26/05/2019.
//  Copyright © 2019 Axel Drozdzynski. All rights reserved.
//

import UIKit
import RealmSwift

class FavorisVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var models : Results<Friend>!
    
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
    }
    
    private func getFavoris() {
        self.models = defRealm.objects(Friend.self)
    }
    
    func reload() {
        self.tableView.reloadData()
    }
    
    // Navigation
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

extension FavorisVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UsersListCell
        let viewModel = UserCellViewModel(model: self.models[indexPath.row])
        let image = UIImage(named: "ic-trash")
        let removeImageView = UIImageView(image: image)
        removeImageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        let tap = UITapGestureRecognizer(target: self, action: #selector(removeTapped))
        removeImageView.isUserInteractionEnabled = true
        removeImageView.addGestureRecognizer(tap)
        removeImageView.tag = indexPath.row
        cell.accessoryView = removeImageView
        cell.viewModel = viewModel
        cell.backgroundColor = .clear
        return cell as UITableViewCell
    }
    
    @objc func removeTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let view = tapGestureRecognizer.view as? UIImageView
        view?.isHidden = true
        guard let index = view?.tag else {
            print("Error guard index")
            return
        }
        let friend = self.models[index]
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            self.performSegue(withIdentifier: "profileVC", sender: indexPath.row)
        }
    }
}
