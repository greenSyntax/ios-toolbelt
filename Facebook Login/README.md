
### Facebook Signin

#### Step0.

Create Project on Facebook Console and get Keys and URL Schme.

#### Step1.

Modify Info.plist, 

```swift

<key>CFBundleURLTypes</key>
<array>
<dict>
<key>CFBundleURLSchemes</key>
<array>
<string>fb17996xxxxxxx</string>
</array>
</dict>
</array>
<key>FacebookAppID</key>
<string>179962xxxxxx</string>
<key>FacebookDisplayName</key>
<string>Restman</string>

<key>LSApplicationQueriesSchemes</key>
<array>
<string>fbapi</string>
<string>fb-messenger-share-api</string>
<string>fbauth2</string>
<string>fbshareextension</string>
</array>

```

#### Step2.

Change AppDelegate, 

```swift

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
// Override point for customization after application launch.

FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)

    return true
}

func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {

let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])

    return handled
}

```


#### Step3.

On your View, 

```swift


FacebookLoginHelper.shared.authenticate(view: self) { (isLoggedIn) in

    if isLoggedIn {
    
        FacebookLoginHelper.shared.getUserProfile(onCompletion: { (user) in

            print(user)
        })
    }
}

```


#### Step4.
