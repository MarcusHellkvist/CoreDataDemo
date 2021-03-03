//
//  User+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Marcus Hellkvist on 2021-03-03.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var firstname: String?
    @NSManaged public var lastname: String?
    @NSManaged public var mobile: Int64
    @NSManaged public var password: String?
    @NSManaged public var username: String?
    @NSManaged public var wishlist: NSSet?
    @NSManaged public var enrolled: NSSet?
    @NSManaged public var bought: NSSet?

}

// MARK: Generated accessors for wishlist
extension User {

    @objc(addWishlistObject:)
    @NSManaged public func addToWishlist(_ value: Course)

    @objc(removeWishlistObject:)
    @NSManaged public func removeFromWishlist(_ value: Course)

    @objc(addWishlist:)
    @NSManaged public func addToWishlist(_ values: NSSet)

    @objc(removeWishlist:)
    @NSManaged public func removeFromWishlist(_ values: NSSet)

}

// MARK: Generated accessors for enrolled
extension User {

    @objc(addEnrolledObject:)
    @NSManaged public func addToEnrolled(_ value: Course)

    @objc(removeEnrolledObject:)
    @NSManaged public func removeFromEnrolled(_ value: Course)

    @objc(addEnrolled:)
    @NSManaged public func addToEnrolled(_ values: NSSet)

    @objc(removeEnrolled:)
    @NSManaged public func removeFromEnrolled(_ values: NSSet)

}

// MARK: Generated accessors for bought
extension User {

    @objc(addBoughtObject:)
    @NSManaged public func addToBought(_ value: Course)

    @objc(removeBoughtObject:)
    @NSManaged public func removeFromBought(_ value: Course)

    @objc(addBought:)
    @NSManaged public func addToBought(_ values: NSSet)

    @objc(removeBought:)
    @NSManaged public func removeFromBought(_ values: NSSet)

}

extension User : Identifiable {

}
