//
//  Restaurant.swift
//  Foodpin
//
//  Created by ScofieldNguyen on 10/14/16.
//  Copyright © 2016 ensteintApp. All rights reserved.
//

import Foundation
import CoreData

class Restaurant: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var type: String
    @NSManaged var location: String
    @NSManaged var phoneNumber: String?
    @NSManaged var image: NSData?
    @NSManaged var isVisited: NSNumber?
    @NSManaged var rate: String?
}