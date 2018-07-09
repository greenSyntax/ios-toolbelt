### Google SignIn

#### Step 0.
Create Project,
https://console.developers.google.com/

Enable Google SignIn and  copy API Secret Key and URL Scheme. 

#### Step 1.
Go to 'Project > Info > URL Type' 

Click on + Button and add your scheme which you'll get from Google Developer Console.

```swift 

com.googleusercontent.apps.347588593514-xxxxxxxxxxxxxxxx

```

#### Step2.
Add these

```swift

import GoogleSignIn

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
// Override point for customization after application launch.

GoogleSignInHelper.shared.initialize()

return true
}

func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
return GIDSignIn.sharedInstance().handle(url as URL?,
sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
annotation: options[UIApplicationOpenURLOptionsKey.annotation])
}

```

#### Step3.

```swift

import UIKit
import GoogleSignIn

class SecondViewController: UIViewController, GIDSignInUIDelegate {

@IBOutlet weak var buttonSignin: GIDSignInButton!

override func viewDidLoad() {
    super.viewDidLoad()

}

@IBAction func signInButtonClicked(_ sender: Any) {

GoogleSignInHelper.shared.requestForSignIn { (user, error) in

        print(user)
    }
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}


}

```


