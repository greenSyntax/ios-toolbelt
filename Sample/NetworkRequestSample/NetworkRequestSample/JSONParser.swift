//
//  JSONParser.swift
//  NetworkRequestSample
//
//  Created by Abhishek Kumar Ravi on 26/10/17.
//  Copyright © 2017 Abhishek Kumar Ravi. All rights reserved.
//

import Foundation
import JSONParserSwift

class JSONParser {

    static func parse<T:ParsableModel>(json: Data)->T? {

        do {
            let baseResponse: T = try JSONParserSwift.parse(data: json)
            return baseResponse
        }
        catch {

        }
        return nil
    }

}
