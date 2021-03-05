//
//  RegisterViewController.swift
//  CoreDataDemo
//
//  Created by Marcus Hellkvist on 2021-02-25.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {
    
    @IBOutlet var navBar: UINavigationBar!
    weak var delegate: UserDelegate?
    
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    @IBOutlet var firstnameField: UITextField!
    @IBOutlet var lastnameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var mobileField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func RegisterButton(_ sender: UIButton) {
        
        let username = usernameField.text ?? "dev1"
        let password = passwordField.text ?? "dev1"
        let firstname = firstnameField.text ?? "dev1"
        let lastname = lastnameField.text ?? "dev1"
        let email = emailField.text ?? "dev1@gmail.com"
        let mobile = Int64(mobileField.text!)!
        
        DataManager.shared.createUser(firstname: firstname, lastname: lastname, email: email, mobile: mobile, username: username, password: password)
        DataManager.shared.saveContext()
        
        delegate?.updateUsers()
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
