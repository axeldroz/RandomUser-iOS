//
//  UsersListCell.swift
//  
//
//  Created by Axel Droz on 22/05/2019.
//

import UIKit
import Nuke

class UsersListCell: UITableViewCell {
    
    @IBOutlet weak var imageProfileView: UIImageView!

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var viewModel : UserViewModel? {
        didSet {
            print(viewModel)
            if let path = viewModel?.imagePath {
                Nuke.loadImage(with: getURLFromPath(path),
                               into: self.imageProfileView)
            }
            if let vm = viewModel {
                print("vm", vm)
                fullNameLabel.text = vm.fullName
                emailLabel.text = vm.email
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // convert string to url
    func getURLFromPath(_ path: String) -> URL {
        let imgPath = path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        return URL.init(string: imgPath)!
    }
    
}