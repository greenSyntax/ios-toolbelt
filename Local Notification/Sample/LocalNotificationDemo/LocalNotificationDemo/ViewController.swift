//
//  ViewController.swift
//  LocalNotificationDemo
//
//  Created by Abhishek Ravi on 21/02/17.
//
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func buttonNotificationClicked(_ sender: Any) {
        
        
         triggerLocalNotification()
    }
    
    func triggerLocalNotification() {
        
        var payloadForNotification = Payload(title: "Hello App", subtitle: "This is my subtitle Text. ", body: "I can't say any thing about App. But, still I want to trigger app.", attachment: nil)
        
        let imageFile = Bundle.main.path(forResource: "localNotification", ofType: "png")
        let imageURL = URL(fileURLWithPath: imageFile!)
        payloadForNotification.attachment = imageURL
        
        // Local Notification Manager
        let notificationManager = LocalNotificationManager.shared
        notificationManager.delegate = self
        notificationManager.requestForLocalNotification(payload: payloadForNotification, trigger: .afterSecond) { (status, error) in
            
            guard error == nil else {
                
                print(error?.errorMessage)
                return
            }
            
            print(status)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: LocalNotificationDelegate {
    
    func hasShownNotification() {
        
        print("Has Shown Notification ....")
    }
}

