## Local Authentication in iOS
There is a framework *LocalAuthentication* which is used to authenticate user through passphrase and biometrics.
It request user to authenticate using only FaceID, TouchID and passphrase.

### LocalAuthentication.swift
Add this file in your Project and use the method *authenticate(handler:)*  

```swift

LocalAuthentication.authenticate { (hasAuthenticated, error) in

            if hasAuthenticated {
                print("Success")
            }
            else {
                print(error)
            }
}

```

### Authentication Errors
When You're authenticating user, then there must be errors. Like, User Cancel the the Dialog for Authentication PopUp or Authentication failed due to wrong passphrase/biometric.
Each and Every Cases are handled in AuthenticationError.

```swift

enum AuthenticationError {

    case BiometricLockOut
    case AppCancel
    case AuthenticationFailed
    case BiometryNotEnrolled
    case BiometryNotAvailable
    case PasscodeNotSet
    case SystemError
    case UserFallback
    case UserCancel
    case Unknown
}

```

### Further Fixes
* For now, it is compatible to iOS 11 only. I'll try to check
