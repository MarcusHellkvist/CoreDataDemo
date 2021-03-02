//
//  CoursesViewController.swift
//  CoreDataDemo
//
//  Created by Marcus Hellkvist on 2021-02-25.
//

import UIKit
import CoreData

class CoursesViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
        
    let cellIdentifier: String = "CourseTableViewCell"
    var categories: [CategoryModel] = [CategoryModel]()
    var signedInUsers: [User] = [User]()
    
    //CORE DATA COURSES
    var coreDataCourses: [Course] = [Course]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    
        getCourses()
    }
    
    func createCourses() {
        DataManager.shared.createCourse(title: "HTML och CSS", desc: "Innehållstext", rating: 5, length: 10, teacher: "Fredrik Lingodricka")
        DataManager.shared.createCourse(title: "Avancerad CSS", desc: "Innehållstext", rating: 4, length: 12, teacher: "Jonny Senap")
        DataManager.shared.createCourse(title: "JavaScript för Nybörjare", desc: "Innehållstext", rating: 3, length: 16, teacher: "Henrik Script")
        DataManager.shared.createCourse(title: "Avancerad JavaScript och serverprogrammering", desc: "Innehållstext", rating: 1, length: 25, teacher: "Henrik Script")
        DataManager.shared.createCourse(title: "JavaScript för Webben", desc: "Innehållstext", rating: 2, length: 8, teacher: "Henrik Script")
        
        DataManager.shared.saveContext()
        coreDataCourses = DataManager.shared.getCourses()

    }
    
    func getCourses() {
        coreDataCourses = DataManager.shared.getCourses()
        if coreDataCourses.count <= 0 {
            createCourses()
        }
    }
    
    func sortCourses() {
        
        let categoryA = CategoryModel(name: "Webbutveckling", courses: [course1, course2])
        let categoryB = CategoryModel(name: "Programmering för mobila enheter", courses: [course3, course4])
        categories.append(categoryA)
        categories.append(categoryB)
    }
    
//    func setupCourses() {
//        // CREATE COURSES
//        let course1 = CourseModel(title: "HTML och CSS",
//                                  description: "Innehållstext",
//                                  length: 6,
//                                  teacher: "Jonny Senap",
//                                  rating: 5)
//
//        let course2 = CourseModel(title: "Avancerad CSS",
//                                  description: "Innehållstext",
//                                  length: 10,
//                                  teacher: "Jonny Senap",
//                                  rating: 5)
//
//        let course3 = CourseModel(title: "Introduktion till Android programmering",
//                                  description: "Innehållstext",
//                                  length: 12,
//                                  teacher: "Berra Bus",
//                                  rating: 2)
//
//        let course4 = CourseModel(title: "Avancerad Android programmering",
//                                  description: "Innehållstext",
//                                  length: 19,
//                                  teacher: "Fredrik Lingonbuske",
//                                  rating: 3)
//
//
//        // CREATE CATEGORIES
//        let categoryA = CategoryModel(name: "Webbutveckling", courses: [course1, course2])
//        let categoryB = CategoryModel(name: "Programmering för mobila enheter", courses: [course3, course4])
//
//        categories.append(categoryA)
//        categories.append(categoryB)
//
//        do{
//            let request = Course.fetchRequest() as NSFetchRequest<Course>
//            self.coreDataCourses = try context.fetch(request)
//        } catch {
//            print("Could not get courses.")
//        }
//    }
}

extension CoursesViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return categories[section].name
//    }
//
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50.0
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return categories.count
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let courses = categories[section].courses
//        return courses.count
        return coreDataCourses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CourseTableViewCell
        
//        let courses = categories[indexPath.section].courses
//        let course = courses[indexPath.row]
        let course = coreDataCourses[indexPath.row]
        
//        cell.titleLabel.text = course.title
//        cell.descriptionLabel.text = course.description
//        cell.ratingLabel.text = String(course.rating)
        
        cell.titleLabel.text = course.title
        cell.descriptionLabel.text = course.desc
        cell.ratingLabel.text = String(course.rating)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let courses = categories[indexPath.section].courses
//        let course = courses[indexPath.row]
        
        let course = coreDataCourses[indexPath.row]
        
        performSegue(withIdentifier: "courseDetailSegue", sender: course)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "courseDetailSegue" {
            guard let destVC = segue.destination as? CourseDetailsViewController else { return }
            //guard let course = sender as? CourseModel else { return }
            guard let course = sender as? Course else { return }
            destVC.course = course
            destVC.delegate = self
        }
    }
}

extension CoursesViewController: CourseDelegate{
    func addCourseToUser(course: Course) {
        
        let signedInUser = DataManager.shared.getSignedInUser()
        signedInUser.addToCourse(course)
        DataManager.shared.saveContext()
    }
}
