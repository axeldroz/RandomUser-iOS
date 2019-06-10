//
//  UsersListCell.swift
//  
//
//  Created by Axel Drozdzynski on 22/05/2019.
//

import UIKit
import Nuke

class UsersListCell: UITableViewCell {
    
    @IBOutlet weak var imageProfileView: UIImageView!

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var viewModel : UserCellViewModel? {
        didSet {
            if let path = viewModel?.imagePath {
                Nuke.loadImage(with: getURLFromPath(path),
                               into: self.imageProfileView)
            }
            if let vm = viewModel {
                fullNameLabel.text = vm.fullName
                emailLabel.text = vm.email
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.initImageLayout()
    }
    
    func initImageLayout() {
        imageProfileView.layer.borderWidth = 1.0
        imageProfileView.layer.masksToBounds = false
        imageProfileView.layer.borderColor = UIHelper.Color.whiteColor.cgColor
        imageProfileView.layer.cornerRadius = imageProfileView.frame.size.height / 2 // imageProfileView.frame.size.height / 4 if you need a nice square
        imageProfileView.clipsToBounds = true
    }

    // convert string to url
    func getURLFromPath(_ path: String) -> URL {
        let imgPath = path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        return URL.init(string: imgPath)!
    }
    
}
