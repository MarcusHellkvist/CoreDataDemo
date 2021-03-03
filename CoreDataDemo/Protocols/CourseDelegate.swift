//
//  CourseDelegate.swift
//  CoreDataDemo
//
//  Created by Marcus Hellkvist on 2021-02-27.
//

import Foundation

protocol CourseDelegate: class {
    func addCourseToUser(course: Course)
    func addCourseToUserBuy(course: Course)
    func addCourseToUserRegister(course: Course)
}
