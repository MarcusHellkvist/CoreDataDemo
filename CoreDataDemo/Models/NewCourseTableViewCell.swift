//
//  NewCourseTableViewCell.swift
//  CoreDataDemo
//
//  Created by Marcus Hellkvist on 2021-03-05.
//

import UIKit

class NewCourseTableViewCell: UITableViewCell {

    @IBOutlet var courseView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var teacherLabel: UILabel!
    @IBOutlet var ratingImage: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleLabel.textColor = UIColor.white
        teacherLabel.textColor = UIColor.white
        priceLabel.textColor = UIColor.white
        
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
