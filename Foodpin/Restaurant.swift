//
//  Restaurant.swift
//  Foodpin
//
//  Created by ScofieldNguyen on 10/14/16.
//  Copyright © 2016 ensteintApp. All rights reserved.
//

import Foundation

class Restaurant {
    var name = ""
    var type = ""
    var location = ""
    var image = ""
    var isVisisted = false
    var phoneNumber = ""
    var rate: Rate = .great
    enum Rate: String {
        case good = "good"
        case dislike = "dislike"
        case great = "great"
    }
    init(name: String, type: String, location: String, phoneNumber: String, image: String, isVisited: Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.phoneNumber = phoneNumber
        self.image = image
        self.isVisisted = isVisited
    }
    
}