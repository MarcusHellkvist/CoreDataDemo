//
//  Course+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Marcus Hellkvist on 2021-03-02.
//
//

import Foundation
import CoreData


extension Course {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Course> {
        return NSFetchRequest<Course>(entityName: "Course")
    }

    @NSManaged public var category: Int64
    @NSManaged public var desc: String?
    @NSManaged public var length: Int64
    @NSManaged public var rating: Int64
    @NSManaged public var teacher: String?
    @NSManaged public var title: String?
    @NSManaged public var status: Int64
    @NSManaged public var ofUser: User?

}

extension Course : Identifiable {

}
