//
//  WishlishTableViewCell.swift
//  CoreDataDemo
//
//  Created by Marcus Hellkvist on 2021-03-07.
//

import UIKit

class WishlishTableViewCell: UITableViewCell {

    @IBOutlet var courseView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var lenghtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.textColor = UIColor.white
        lenghtLabel.textColor = UIColor.white
        
        self.backgroundColor = UIColor.myBlue
        
        //Style cell
        courseView.layer.cornerRadius = 8
        courseView.layer.backgroundColor = UIColor.myLightBlue.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
