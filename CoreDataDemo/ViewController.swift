////
////  ViewController.swift
////  CoreDataDemo
////
////  Created by Marcus Hellkvist on 2021-02-25.
////
//
//import UIKit
//import CoreData
//
//class ViewController: UIViewController {
//
//    @IBOutlet var tableView: UITableView!
//    
//    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    
//    var items: [Person]?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        tableView.dataSource = self
//        tableView.delegate = self
//        
//        fetchPeople()
//        
//    }
////    func fetchPeople() {
////        // Fetch data from core data and display in tableview
////        do{
////
////            // Create request
////            let request = Person.fetchRequest() as NSFetchRequest<Person>
////
////            // Set the filtering and sorting on the request
////            //let predicate = NSPredicate(format: "name CONTAINS %@", "Henrik")
////            //request.predicate = predicate
////
////            let sort = NSSortDescriptor(key: "name", ascending: true)
////            request.sortDescriptors = [sort]
////
////            self.items = try context.fetch(request)
////            DispatchQueue.main.async {
////                self.tableView.reloadData()
////            }
////        } catch {
////            print("Could not retrive persons.")
////        }
////    }
//    
////    @IBAction func addTapped(_ sender: UIBarButtonItem) {
////        let alert = UIAlertController(title: "Add Person", message: "What is their name?", preferredStyle: .alert)
////        alert.addTextField()
////        
////        let submitButton = UIAlertAction(title: "Add", style: .default) { (action) in
////            
////            // Get the textfield from the alert.
////            let textfield = alert.textFields![0]
////            
////            // Create a new Person object
////            let newPerson = Person(context: self.context)
////            newPerson.name = textfield.text
////            newPerson.age = 20
////            newPerson.gender = "Male"
////            
////            // Save data
////            do{
////                try self.context.save()
////            } catch {
////                print("Could not save new person object.")
////            }
////            
////            // Re-fetch the data
////            self.fetchPeople()
////            
////        }
////        
////        // Add button to alert
////        alert.addAction(submitButton)
////        
////        // Present button to alert
////        self.present(alert, animated: true, completion: nil)
////        
////    }
//    
//
//}
//
//extension ViewController: UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.items?.count ?? 0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
//        
//        let person = self.items![indexPath.row]
//        
//        cell.textLabel?.text = person.name
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        // Selected person
//        let person = self.items![indexPath.row]
//        
//        // Create alert
//        let alert = UIAlertController(title: "Edit Person", message: "Edit name:", preferredStyle: .alert)
//        alert.addTextField()
//        let textField = alert.textFields![0]
//        textField.text = person.name
//        
//        let saveButton = UIAlertAction(title: "Save", style: .default) { (action) in
//            
//            // Get the textfield for the alert
//            let textfield = alert.textFields![0]
//            
//            // Edit the name
//            person.name = textfield.text
//            
//            // Save the updated data
//            do{
//                try self.context.save()
//            } catch {
//                print("Could not update the person.")
//            }
//            
//            self.fetchPeople()
//            
//        }
//        
//        alert.addAction(saveButton)
//        self.present(alert, animated: true, completion: nil)
//        
//        
//        
//    }
//    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        
//        // Create swipe action
//        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
//            
//            // Which person to remove
//            let personToRemove = self.items![indexPath.row]
//            
//            // Remove the person
//            self.context.delete(personToRemove)
//            
//            // Save the data
//            do{
//                try self.context.save()
//            } catch {
//                print("Unable to save changes.")
//            }
//            
//            // Refetch the data
//            self.fetchPeople()
//            
//        }
//        
//        return UISwipeActionsConfiguration(actions: [action])
//    }
//    
//    
//}
