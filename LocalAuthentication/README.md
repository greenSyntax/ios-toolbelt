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

1. AppCancel
   - Authentication was canceled by application (e.g. invalidate was called while
     authentication was in progress).
2. Authentication failed
   - Authentication was not successful, because user failed to provide valid credentials.

3. Biometry Lockout
   - Authentication was not successful, because there were too many failed biometry attempts and biometry is now locked. Passcode is required to unlock biometry
4. Biometry Not Available
   - Authentication could not start, because biometry is not available on the device.
5. Biometry Not Enrolled
   - Authentication could not start, because biometry has no enrolled identities.
6. Passcode Not Set
   - Authentication could not start, because passcode is not set on the device.
7. System Cancel
   - Authentication was canceled by system (e.g. another application went to foreground).
8. User Cancel
   - Authentication was canceled by user (e.g. tapped Cancel button).
9. User Fallback
   - Authentication was canceled, because the user tapped the fallback button (Enter Password).


And, these cases are handled under enum in LocalAuthentication.swift,
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
* Remove the default / Handle all access
