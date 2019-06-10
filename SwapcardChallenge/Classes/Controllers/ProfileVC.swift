//
//  ProfileVC.swift
//  SwapcardChallenge
//
//  Created by Axel Droz on 05/06/2019.
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
    @IBOutlet weak var username2Label: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var viewModel : UserProfileViewModel? {
        didSet {
            //self.setLayoutText(viewModel: viewModel!)
        }
    }
    
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
        //UIHelper.loadNavigationBarStyle(self.navigationController!)
        UIHelper.loadNavigationBarStyle(self.navigationController!)
        //UIHelper.loadNavigationBarStyle(self.navigationController!)
        self.view.backgroundColor = gray
        self.scrollView.backgroundColor = gray
        self.addButton.setTitleColor(UIHelper.Color.greenSwapcard, for: .normal)
        self.initImageLayout()
        self.setLayoutText(viewModel: self.viewModel!)
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
        //self.usernameLabel.text = viewModel.username
        self.cityLabel.text = viewModel.city
        self.stateLabel.text = viewModel.state
        self.timezoneLabel.text = viewModel.timezone
        self.genderLabel.text = viewModel.gender
        self.username2Label.text = viewModel.username
        self.emailLabel.text = viewModel.email
        self.phoneLabel.text = viewModel.phone
        self.ageLabel.text = viewModel.age
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

