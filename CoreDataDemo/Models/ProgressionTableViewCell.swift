//
//  ProgressionTableViewCell.swift
//  CoreDataDemo
//
//  Created by Marcus Hellkvist on 2021-03-08.
//

import UIKit

class ProgressionTableViewCell: UITableViewCell {
    
    @IBOutlet var courseView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var teacherLabel: UILabel!
    @IBOutlet var progressionView: UIProgressView!
    @IBOutlet var progressionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleLabel.textColor = UIColor.white
        teacherLabel.textColor = UIColor.white
        progressionLabel.textColor = UIColor.white
        
        self.backgroundColor = UIColor.myBlue
        progressionView.progressTintColor = UIColor.myYellow
        
        //Style cell
        courseView.layer.cornerRadius = 8
        courseView.layer.backgroundColor = UIColor.myLightBlue.cgColor
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
