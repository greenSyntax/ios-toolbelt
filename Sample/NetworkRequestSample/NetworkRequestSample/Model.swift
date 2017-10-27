//
//  Model.swift
//  NetworkRequestSample
//
//  Created by Abhishek Kumar Ravi on 26/10/17.
//  Copyright © 2017 Abhishek Kumar Ravi. All rights reserved.
//

import Foundation
import JSONParserSwift

class Profile: ParsableModel {

    var name: String?
    var location: String?
    var age: String?
    var picture: String?
    var website: String?
}

class Friends : ParsableModel {

    var friends:[Friend]?
}

class Friend: ParsableModel {

    var name:String?
    var age:String?
    var city:String?
    var date_of_birth:String?
    var hobbies: [String]?
    var profile_picture:String?
}
