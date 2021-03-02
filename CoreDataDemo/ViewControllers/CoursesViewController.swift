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
    
    var signedInUser: User!
        
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
    
        signedInUser = DataManager.shared.getSignedInUser()
        
        getCourses()
        sortCourses()
    }
    
    func createCourses() {
        
        //WEBBUTVECKLING
        DataManager.shared.createCourse(title: "HTML och CSS", desc: "Innehållstext", rating: 5, length: 10, teacher: "Fredrik Lingodricka", category: 1)
        DataManager.shared.createCourse(title: "Avancerad CSS", desc: "Innehållstext", rating: 4, length: 12, teacher: "Jonny Senap", category: 1)
        DataManager.shared.createCourse(title: "JavaScript för Nybörjare", desc: "Innehållstext", rating: 3, length: 16, teacher: "Henrik Script", category: 1)
        DataManager.shared.createCourse(title: "Avancerad JavaScript och serverprogrammering", desc: "Innehållstext", rating: 1, length: 25, teacher: "Henrik Script", category: 1)
        DataManager.shared.createCourse(title: "JavaScript för Webben", desc: "Innehållstext", rating: 2, length: 8, teacher: "Henrik Script", category: 1)
        DataManager.shared.createCourse(title: "ASP.NET Core MVC", desc: "Innehållstext", rating: 2, length: 16, teacher: "Anders Megapanna", category: 1)
        
        //PROGRAMMERING FÖR MOBILA ENHETER
        DataManager.shared.createCourse(title: "Introduktion till Android Programmering", desc: "Innehållstext", rating: 5, length: 20, teacher: "William Fruktkorg", category: 2)
        DataManager.shared.createCourse(title: "Avancerad Android programmering", desc: "Innehållstext", rating: 4, length: 16, teacher: "William Fruktkorg", category: 2)
        DataManager.shared.createCourse(title: "iOS Utveckling med Objective-C", desc: "Innehållstext", rating: 5, length: 4, teacher: "Michael von Bilexpert", category: 2)
        DataManager.shared.createCourse(title: "iOS utveckling med Swift", desc: "Innehållstext", rating: 5, length: 30, teacher: "Michael von Bilexpert", category: 2)
        DataManager.shared.createCourse(title: "Design och layout för mobila enheter", desc: "Innehållstext", rating: 2, length: 11, teacher: "Larry Stenkast", category: 2)
        
        //BACKEND PROGRAMMERING
        DataManager.shared.createCourse(title: "REST API med node.js", desc: "Innehållstext", rating: 3, length: 9, teacher: "Jimmy Motvind", category: 3)
        DataManager.shared.createCourse(title: "Web API med .NET Core", desc: "Innehållstext", rating: 4, length: 5, teacher: "Jimmy Motvind", category: 3)
        
        //DATABASER
        DataManager.shared.createCourse(title: "Administrera MS SQL Server", desc: "Innehållstext", rating: 5, length: 9, teacher: "Jessica Snabb", category: 4)
        DataManager.shared.createCourse(title: "Databas design", desc: "Innehållstext", rating: 1, length: 14, teacher: "Lars-Åke Hjulbent", category: 4)
        DataManager.shared.createCourse(title: "Bygga system med MongoDB", desc: "Innehållstext", rating: 2, length: 18, teacher: "David Databas", category: 4)
        DataManager.shared.createCourse(title: "Vad är ORM? Hur använder man ett sådant verktyg", desc: "Innehållstext", rating: 5, length: 2, teacher: "Sir Väss", category: 4)
        
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
        
        var categoryA = CategoryModel(name: "Webbutveckling")
        var categoryB = CategoryModel(name: "Programmering för mobila enheter")
        var categoryC = CategoryModel(name: "Backend Programmering")
        var categoryD = CategoryModel(name: "Databaser")
        
        for course in coreDataCourses {
            switch course.category {
            case 1:
                categoryA.courses.append(course)
            case 2:
                categoryB.courses.append(course)
            case 3:
                categoryC.courses.append(course)
            case 4:
                categoryD.courses.append(course)
            default:
                print("Error, could not find any category.")
            }
        }
        
        categories.append(categoryA)
        categories.append(categoryB)
        categories.append(categoryC)
        categories.append(categoryD)
        
    }
}

extension CoursesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].name
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let courses = categories[section].courses
        return courses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CourseTableViewCell
        
        let courses = categories[indexPath.section].courses
        let course = courses[indexPath.row]
        
        cell.titleLabel.text = course.title
        cell.descriptionLabel.text = course.desc
        cell.ratingLabel.text = String(course.rating)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let courses = categories[indexPath.section].courses
        let course = courses[indexPath.row]
        
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
    
    /*
     Status:
     0 Default
     1 Wishlist
     2 Bought
     */
    
    func addCourseToUser(course: Course) {
        course.status = 1
        signedInUser.addToCourse(course)
        DataManager.shared.saveContext()
    }
    
    func addCourseToUserBuy(course: Course) {
        course.status = 2
        signedInUser.addToCourse(course)
    }
    
}
