//
//  UserCell.swift
//  SnapDevChat
//
//  Created by Melissa Bain on 9/1/16.
//  Copyright © 2016 MB Consulting. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var firstNameLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        setCheckmark(selected: false)
    }
    
    func updateUI(user: User) {
        firstNameLabel.text = user.firstName
    }
    
    func setCheckmark(selected: Bool) {
        
        let imageStr = selected ? "messageindicatorchecked1" : "messageindicator1"
        
        self.accessoryView = UIImageView(image: UIImage(named: imageStr))
    }
}
