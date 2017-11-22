# Firebase Authentication

It is a Backend Service to authorise using Email/Password or Phone Number/Password. It also supports OAuth2.0 and OpenID Authentication like Google SignIn, Facebook Authentication, Twiiter Authentication and Github Authentication.

*AuthenticationWorker* is singleton class for Firebase Authentication

*Note* : In Firebase Console, you've to *enable* Sign-In Method for *Email/Password* provider.

### SigIn with Existing User
In AuthenticationWorker, there is a method called *login(handler:)* which will return user:FIRUser and error:Error in completion closure.

```swift

let user = UserModel(email: "ab.abhishek.ravi@gmail.com", password: "myPassword")

AuthenticationWorker.shared.login(user: user, handler: { (user, error) in

guard error == nil else {

  // Error Occurred While Authentication
  print(error.localizedDescription)

  return
}

//Successfully Authenticated
print(user)

})

```

### SignUp New User
In AuthenticationWorker, we have a method called *register(user: handler:)*. In Response, It will return UserModel FIRUser type object along with the Error Optional

```swift

AuthenticationWorker.shared.register(user: user, handler: { (user, error) in

guard error == nil else {

  //onError Occurred While Registering
  print(error.localizedDescription)
  return
}

//onSuccessfull Registration
print(user)

})

```
### Get Active User
In Authentication Worker, we have a method called *isLoggedIn()->User?*. As you can, this method will either return User instance or nil.

```swift

if let user = AuthenticationWorker.shared.isLoggedIn() {
            print(user)
}

```

### Update password
In Authentication Worker, we've a method called *updatePassword(newPassword: handler:)* to change the loggedin account password.

```swift

AuthenticationWorker.shared.updatePassword(newPassword: "NewPassword") { (hasChanged, error) in

            guard error == nil else {
                print(error?.localizedDescription)
                return
            }

            //onSuccess
            print(hasChanged)
}

```

### Update Email Address
In Authentication Worker, there is a method called *updateEmailAddress(newEmail: hanlder:)* which will update the email address of the logged-in account.


```swift

AuthenticationWorker.shared.updateEmailAddress(newEmail: "newEmailAddress@gmail.com") { (user, error) in

            guard error == nil else {
                print(error?.localizedDescription)
                return
            }

            //Successfully changed Email Address of LoggedIn Account
            print(user)
}

```

### Send Verification Mail
If you want to integrate Verification-Process while registering you can call *sendVerificationMail(handler:)* method to send Verification Mail to logged account.

And, Whenever you logged-in any account, you'll get a bool property isEmailVerified in *User* which will return whether you account is verified or not.


```swift

AuthenticationWorker.shared.sendVerificationMail { (hasSent, error) in

            guard error == nil else {
                print(error?.localizedDescription)
                return
            }

            //onSuccessfully Sent Verification Mail
            print(hasSent)
}

```


### Remove Account
In Authentication Worker, you have a provision to delete User from the Firebase Authentication Catalog.

```swift

AuthenticationWorker.shared.deleteUser { (hasDeleted, error) in

            guard error == nil else {
                print(error?.localizedDescription)
                return
            }

            //onSuccessfull Deletion of User
            print(hasDeleted)
}

```
