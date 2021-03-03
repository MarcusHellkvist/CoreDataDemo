//
//  CourseDelegate.swift
//  CoreDataDemo
//
//  Created by Marcus Hellkvist on 2021-02-27.
//

import Foundation

protocol CourseDelegate: class {
    func addToWishlist(course: Course)
    func addToBought(course: Course)
    func addToEnrolled(course: Course)
}
