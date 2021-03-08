//
//  DataManager.swift
//  CoreDataDemo
//
//  Created by Marcus Hellkvist on 2021-03-01.
//

import Foundation
import CoreData

class DataManager {
    
    static let shared = DataManager()
    var signedInUserId: String!
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // FOR TESTING PURPOSE ONLY!!!
    func deleteAllUsers() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "User")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print("Could not delete all users \(error)")
        }
    }
    
    // FOR TESTING PURPOSE ONLY!!!
    func deleteAllCourses(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Course")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print("Could not delete all courses \(error)")
        }
    }
    
    func createUser(firstname: String, lastname: String, email: String, mobile: Int64, username: String, password: String){
        let user = User(context: persistentContainer.viewContext)
        user.firstname = firstname
        user.lastname = lastname
        user.email = email
        user.mobile = mobile
        user.username = username
        user.password = password
    }
    
    func getUsers() -> [User] {
        let request: NSFetchRequest<User> = User.fetchRequest()
        var users: [User] = []
        
        do {
            users = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching users")
        }
        return users
    }
    
    func getSignedInUser() -> User {
        let request: NSFetchRequest<User> = User.fetchRequest()
        let predicate = NSPredicate(format: "username == %@", signedInUserId)
        request.predicate = predicate
        var signedInUser: [User] = []
        
        do {
            signedInUser = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching signed in user")
        }
        
        return signedInUser[0]
    }
    
    func createCourse(id: Int64, title: String, desc: String, rating: Int64, length: Int64, teacher: String, category: Int64, price: Int64){
        let course = Course(context: persistentContainer.viewContext)
        course.id = id
        course.title = title
        course.desc = desc
        course.rating = rating
        course.length = length
        course.teacher = teacher
        course.category = category
        course.price = price
        course.progression = 0.0
    }
    
    func getCourses() -> [Course] {
        let request: NSFetchRequest<Course> = Course.fetchRequest()
        var courses: [Course] = []
        
        do{
            courses = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching courses")
        }
        return courses
    }
}
