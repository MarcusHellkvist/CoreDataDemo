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
    var signedInUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        signedInUser = DataManager.shared.getSignedInUser()
        userBoughtCourses = DataManager.shared.getUserBoughtCourses(user: signedInUser)
        print("\(userBoughtCourses.count)")
        //getBoughtCourses()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        //getBoughtCourses()
    }
    
//    func getBoughtCourses() {
//        userBoughtCourses.removeAll()
//        if let allCourses = signedInUser.course?.allObjects as? [Course]{
//            for course in allCourses {
//                if course.status == 2 {
//                    userBoughtCourses.append(course)
//                }
//            }
//        }
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//    }

}

extension ActiveCoursesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userBoughtCourses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CourseTableViewCell
        
        let course = userBoughtCourses[indexPath.row]
        
        cell.titleLabel.text = course.title
        cell.descriptionLabel.text = course.desc
        cell.ratingLabel.text = String(course.rating)
        
        return cell
    }


}
