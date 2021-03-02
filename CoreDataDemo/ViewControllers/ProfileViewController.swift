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
