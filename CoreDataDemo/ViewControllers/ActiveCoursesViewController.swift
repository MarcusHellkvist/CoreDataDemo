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
    
    let cellIdentifier: String = "courseCell"
    
    var userBoughtCourses: [Course] = [Course]()
    var userEnrolledCourses: [Course] = [Course]()
    var allCourses: [[Course]] = [[Course]]()
    var signedInUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.backgroundColor = UIColor.myBlue.cgColor
        tableView.backgroundColor = UIColor.myBlue
        
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 50))
        returnedView.backgroundColor = UIColor.myBlue
        
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: self.view.bounds.size.width, height: 50))
        
        switch section {
        case 0:
            label.text = "Bought"
        case 1:
            label.text = "Registered"
        default:
            label.text = "Unknown"
        }
        
        label.textColor = UIColor.myWhite
        returnedView.addSubview(label)
        
        return returnedView
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allCourses.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCourses[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProgressionTableViewCell
        
        let course = allCourses[indexPath.section][indexPath.row]
        
        cell.titleLabel.text = course.title
        cell.teacherLabel.text = course.teacher
        cell.progressionView.setProgress(course.progression, animated: true)
        cell.progressionLabel.text = ("\(course.progression * 100) % Complete")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = allCourses[indexPath.section][indexPath.row]
        print(course.progression)
        if course.progression >= 1.0 {
            course.progression = 1.0
        } else {
            course.progression += 0.1
        }
        tableView.reloadData()
        DataManager.shared.saveContext()
    }


}
