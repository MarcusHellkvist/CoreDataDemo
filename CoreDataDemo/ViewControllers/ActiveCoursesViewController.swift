//
//  ActiveCoursesViewController.swift
//  CoreDataDemo
//
//  Created by Marcus Hellkvist on 2021-03-02.
//

import UIKit

class ActiveCoursesViewController: UIViewController {

    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var tableView: UITableView!
    
    let cellIdentifier: String = "CourseTableViewCell"
    
    var userBoughtCourses: [Course] = [Course]()
    var userEnrolledCourses: [Course] = [Course]()
    var allCourses: [[Course]] = [[Course]]()
    var signedInUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        signedInUser = DataManager.shared.getSignedInUser()
        getAllCourses()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        getAllCourses()
    }
    
    func getAllCourses() {
        // CLEAN ALL ARRAYS
        userBoughtCourses.removeAll()
        userEnrolledCourses.removeAll()
        allCourses.removeAll()
        
        if let bought = signedInUser.bought?.allObjects as? [Course]{
            allCourses.append(bought)
        }
        
        if let enrolled = signedInUser.enrolled?.allObjects as? [Course] {
            allCourses.append(enrolled)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }

}

extension ActiveCoursesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Bought"
        case 1:
            return "Registered"
        default:
            return "Unknown"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allCourses.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCourses[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CourseTableViewCell
        
        let course = allCourses[indexPath.section][indexPath.row]
        
        cell.titleLabel.text = course.title
        cell.descriptionLabel.text = course.desc
        cell.ratingLabel.text = String(course.rating)
        
        return cell
    }


}
