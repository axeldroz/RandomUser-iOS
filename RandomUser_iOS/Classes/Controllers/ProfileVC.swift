//
//  ProfileVC.swift
//  RandomUser_iOS
//
//  Created by Axel Drozdzynski on 05/06/2019.
//  Copyright © 2019 Axel Droz. All rights reserved.
//

import UIKit
import Nuke

class ProfileVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var timezoneLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var viewModel : UserProfileViewModel? {
        didSet {
        }
    }
    weak var usersListVC : UsersListVC?
    var index : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gray = UIColor(red: 232 / 255, green: 232 / 255, blue: 232 / 255, alpha: 1)
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: view.frame.height))
        titleLabel.text = ""
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
        UIHelper.loadNavigationBarStyle(self.navigationController!)
        self.view.backgroundColor = gray
        self.scrollView.backgroundColor = gray
        self.addButton.setTitleColor(UIHelper.Color.greenSwapcard, for: .normal)
        self.initImageLayout()
        if let vm = self.viewModel {
            self.setLayoutText(viewModel: vm)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.contentSize = CGSize(width: 375, height: 750)
    }
    
    func initImageLayout() {
        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIHelper.Color.whiteColor.cgColor
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        imageView.clipsToBounds = true
    }
    
    private func setLayoutText(viewModel : UserProfileViewModel) {
        let path = viewModel.imagePath
        
        if path != "" {
            Nuke.loadImage(with: UIHelper.getURLFromPath(path),
                           into: self.imageView)
        }
        self.fullnameLabel.text = viewModel.fullname
        self.usernameLabel.text = viewModel.username
        self.cityLabel.text = viewModel.city
        self.stateLabel.text = viewModel.state
        self.timezoneLabel.text = viewModel.timezone
        self.genderLabel.text = viewModel.gender
        self.emailLabel.text = viewModel.email
        self.phoneLabel.text = viewModel.phone
        self.ageLabel.text = viewModel.age
        self.addButton.isHidden = !viewModel.addVisible
    }
    
    @IBAction func addPressed(_ sender: Any) {
        if let index = index {
            self.usersListVC?.addFriendToLocalDB(index: index) {
                self.navigationController?.popViewController(animated: true)
            }
            //self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
