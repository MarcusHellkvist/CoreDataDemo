//
//  LoginViewController.swift
//  CoreDataDemo
//
//  Created by Marcus Hellkvist on 2021-02-25.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    var users: [User] = [User]()
    var testUsers: [Course] = [Course]()
    var userListOfCourses: [Course] = [Course]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Uncomment to reset database
        //DataManager.shared.deleteAllUsers()
        //DataManager.shared.deleteAllCourses()
        
        users = DataManager.shared.getUsers()
        listAllUsers()

    }
    
    func listAllUsers() {
        for user in users {
            print("\(user.username) \(user.password)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "registerSegue" {
            guard let destVC = segue.destination as? RegisterViewController else { return }
            destVC.delegate = self
        }
    }

    @IBAction func LoginButton(_ sender: UIButton) {
        
        let username = usernameField.text
        let password = passwordField.text
        
        if users.isEmpty {
            print("No customers registered yet.")
            return
        }
        
        for user in users {
            if user.username == username && user.password == password {
                print("Signing in. Please Wait.")
                DataManager.shared.signedInUserId = user.username
                performSegue(withIdentifier: "coursesSegue", sender: self)
            } else {
                print("Something went wrong.")
            }
        }
        
    }
    
    @IBAction func RegisterButton(_ sender: UIButton) {
        performSegue(withIdentifier: "registerSegue", sender: self)
    }
}

extension LoginViewController: UserDelegate{
    func updateUsers() {
        print("Update list of users")
        users = DataManager.shared.getUsers()
    }
}
