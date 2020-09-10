//
//  UserTableViewCell.swift
//  Users-Miho
//
//  Created by Mac on 9/9/20.
//  Copyright © 2020 Miho. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var activityIndicatorView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var noteImageView: UIImageView!
    @IBOutlet weak var userDescriptionLabel: UILabel!
    
    func configure(_ isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
            self.bringSubviewToFront(activityIndicatorView)
        } else {
            activityIndicator.stopAnimating()
            self.sendSubviewToBack(activityIndicatorView)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userProfileImageView.roundView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userProfileImageView.image = nil
        userNameLabel.text = nil
        userDescriptionLabel.text = nil
    }
}
