//
//  ProfileVC.swift
//  SwapcardChallenge
//
//  Created by Axel Droz on 05/06/2019.
//  Copyright © 2019 Axel Droz. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
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
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.contentSize = CGSize(width: 375, height: 950)
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

