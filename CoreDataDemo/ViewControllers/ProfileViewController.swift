//
//  ProfileViewController.swift
//  CoreDataDemo
//
//  Created by Marcus Hellkvist on 2021-02-25.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var navBar: UINavigationBar!
    
    var userCourses: [Course] = [Course]()
    let cellIdentifier: String = "courseCell"
    var signedInUser: User!
    
    //NEW!
    var userWishlist: [Course] = [Course]()
    
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // STYLE
        view.layer.backgroundColor = UIColor.myBlue.cgColor
        tableView.backgroundColor = UIColor.myBlue
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        signedInUser = DataManager.shared.getSignedInUser()
        
        getWishlist()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getWishlist()
    }
    
    func getWishlist() {
        userWishlist.removeAll()
        if let wishlist = signedInUser.wishlist?.allObjects as? [Course] {
            userWishlist = wishlist
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    @objc func refreshTableView(){
        getWishlist()
        refreshControl.endRefreshing()

    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userWishlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NewCourseTableViewCell
        
        let course = userWishlist[indexPath.row]
        
        cell.titleLabel.text = course.title
        cell.teacherLabel.text = course.teacher
        cell.ratingImage.image = RatingModel.getRatingImage(number: course.rating)
        cell.priceLabel.text = ("\(course.price) kr")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = userWishlist[indexPath.row]

        let alert = UIAlertController(title: "\(course.title!)", message: "What do you wanna do?", preferredStyle: .alert)

        let buyButton = UIAlertAction(title: "Buy", style: .default) { (action) in
            self.signedInUser.removeFromWishlist(course)
            self.signedInUser.addToBought(course)
            DataManager.shared.saveContext()
        }
        let registerButton = UIAlertAction(title: "Register", style: .default) { (action) in
            self.signedInUser.removeFromWishlist(course)
            self.signedInUser.addToEnrolled(course)
            DataManager.shared.saveContext()
        }
        let deleteButton = UIAlertAction(title: "Remove from wishlist", style: .destructive) { (action) in
            self.signedInUser.removeFromWishlist(course)
            DataManager.shared.saveContext()
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

                let course = self.userWishlist[indexPath.row]
                self.signedInUser.removeFromWishlist(course)
                DataManager.shared.saveContext()
                self.getWishlist()

            }

        return UISwipeActionsConfiguration(actions: [action])
    }
}
