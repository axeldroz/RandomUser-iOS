//
//  FavorisVC.swift
//  
//
//  Created by Axel Drozdzynski on 26/05/2019.
//

import UIKit

class FavorisVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var models = [UserModel]()
    
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apiService.fetchUsers2(vc: self)
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

extension FavorisVC : UITableViewDelegate, UITableViewDataSource {
    
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
        
        view?.isHidden = true
        // add to db local
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
}


