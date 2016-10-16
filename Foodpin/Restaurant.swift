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
    init(name: String, type: String, location: String, image: String, isVisited: Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isVisisted = isVisited
    }
    
}