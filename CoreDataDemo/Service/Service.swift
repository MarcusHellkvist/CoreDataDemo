//
//  Service.swift
//  CoreDataDemo
//
//  Created by Marcus Hellkvist on 2021-02-27.
//

import Foundation

class Service {
    
    static let instance = Service()
    var username: String?
    
    private init(){
        print("init the singleton")
    }
}
