//
//  ProfileViewController.swift
//  CoreDataDemo
//
//  Created by Marcus Hellkvist on 2021-02-25.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {

    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var navBar: UINavigationBar!
    
    var userCourses: [Course] = [Course]()
    let cellIdentifier: String = "CourseTableViewCell"
    var signedInUser: User!
    
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        signedInUser = DataManager.shared.getSignedInUser()
        
        getUserCourses()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getUserCourses()
    }
    
    @objc func refreshTableView(){
        getUserCourses()
        refreshControl.endRefreshing()
        
    }
    
    func getUserCourses() {
        userCourses.removeAll()
        if let allCourses = signedInUser.course?.allObjects as? [Course]{
            for course in allCourses {
                if course.status == 1 {
                    userCourses.append(course)
                }
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func updateCourseStatus(course: Course, statusNumber: Int) {
        course.status = Int64(statusNumber)
        DataManager.shared.saveContext()
        getUserCourses()
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CourseTableViewCell
        
        let course = userCourses[indexPath.row]
        
        cell.titleLabel.text = course.title
        cell.descriptionLabel.text = course.desc
        cell.ratingLabel.text = String(course.rating)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = userCourses[indexPath.row]
        
        let alert = UIAlertController(title: "\(course.title)", message: "What do you wanna do?", preferredStyle: .alert)
        
        let buyButton = UIAlertAction(title: "Buy", style: .default) { (action) in
            self.updateCourseStatus(course: course, statusNumber: 2)
        }
        let registerButton = UIAlertAction(title: "Register", style: .default) { (action) in
            //self.updateCourseStatus(course: course, statusNumber: 3)
        }
        let deleteButton = UIAlertAction(title: "Remove from wishlist", style: .destructive) { (action) in
            self.updateCourseStatus(course: course, statusNumber: 0)
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(buyButton)
        alert.addAction(registerButton)
        alert.addAction(deleteButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
        
                let course = self.userCourses[indexPath.row]
                self.signedInUser.removeFromCourse(course)
                DataManager.shared.saveContext()
                self.getUserCourses()
        
            }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}
