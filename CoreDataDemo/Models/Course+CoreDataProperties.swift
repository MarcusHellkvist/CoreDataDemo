//
//  Course+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Marcus Hellkvist on 2021-03-08.
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
    @NSManaged public var id: Int64
    @NSManaged public var length: Int64
    @NSManaged public var price: Int64
    @NSManaged public var progression: Float
    @NSManaged public var rating: Int64
    @NSManaged public var teacher: String?
    @NSManaged public var title: String?
    @NSManaged public var ofUserBought: NSSet?
    @NSManaged public var ofUserEnrolled: NSSet?
    @NSManaged public var ofUserWishlist: NSSet?

}

// MARK: Generated accessors for ofUserBought
extension Course {

    @objc(addOfUserBoughtObject:)
    @NSManaged public func addToOfUserBought(_ value: User)

    @objc(removeOfUserBoughtObject:)
    @NSManaged public func removeFromOfUserBought(_ value: User)

    @objc(addOfUserBought:)
    @NSManaged public func addToOfUserBought(_ values: NSSet)

    @objc(removeOfUserBought:)
    @NSManaged public func removeFromOfUserBought(_ values: NSSet)

}

// MARK: Generated accessors for ofUserEnrolled
extension Course {

    @objc(addOfUserEnrolledObject:)
    @NSManaged public func addToOfUserEnrolled(_ value: User)

    @objc(removeOfUserEnrolledObject:)
    @NSManaged public func removeFromOfUserEnrolled(_ value: User)

    @objc(addOfUserEnrolled:)
    @NSManaged public func addToOfUserEnrolled(_ values: NSSet)

    @objc(removeOfUserEnrolled:)
    @NSManaged public func removeFromOfUserEnrolled(_ values: NSSet)

}

// MARK: Generated accessors for ofUserWishlist
extension Course {

    @objc(addOfUserWishlistObject:)
    @NSManaged public func addToOfUserWishlist(_ value: User)

    @objc(removeOfUserWishlistObject:)
    @NSManaged public func removeFromOfUserWishlist(_ value: User)

    @objc(addOfUserWishlist:)
    @NSManaged public func addToOfUserWishlist(_ values: NSSet)

    @objc(removeOfUserWishlist:)
    @NSManaged public func removeFromOfUserWishlist(_ values: NSSet)

}

extension Course : Identifiable {

}
