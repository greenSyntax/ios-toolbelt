
//
//  ViewController.swift
//  NetworkRequestSample
//
//  Created by Abhishek Kumar Ravi on 26/10/17.
//  Copyright © 2017 Abhishek Kumar Ravi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let profileUrl = "http://api.greensyntax.co.in/profile.json"
        let friendsUrl = "http://api.greensyntax.co.in/sample.json"

        let api = ApiStruct(endpoint: URL(string: friendsUrl), headers: nil, body: nil)

        WSManager.shared.getResponse(api: api) { (response:Friends?, error) in

            print(response)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

