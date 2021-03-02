//
//  CourseDetailsViewController.swift
//  CoreDataDemo
//
//  Created by Marcus Hellkvist on 2021-02-25.
//

import UIKit
import CoreData

class CourseDetailsViewController: UIViewController {

    @IBOutlet var navBar: UINavigationBar!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var teacherLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var lengthLabel: UILabel!
    
    var course: Course?
    weak var delegate: CourseDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupDetailCourse()

    }
    
    func setupNavBar() {
        let item = UINavigationItem(title: course?.title ?? "Could not find")
        item.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navBar.items = [item]
    }
    
    func setupDetailCourse() {
        
        if let course = course {
            titleLabel.text = course.title
            descriptionLabel.text = course.desc
            lengthLabel.text = String(course.length)
            teacherLabel.text = course.teacher
            ratingLabel.text = String(course.rating)
        } else {
            print("course is nil")
        }
        
    }
    
    @objc func cancelTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func AddToWishlist(_ sender: UIButton) {
        delegate?.addCourseToUser(course: course!)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func BuyButton(_ sender: UIButton) {
    }
    
}
