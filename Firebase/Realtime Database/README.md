# Firebase Realtime Database
Firebase Realtime Database gives you a NoSQL Database which will be synced across all the clients in realtime and remain available when app goes offline.

### Points
* Data is stored in JSON format.
* It has Cross-Platform support
* It's a RealTime Database which'll be synced whenever there is any change in database.
* Works in Offline mode also. Firebase keeps mirror database in local app.
* Scalable across multiple database.

### Setup
First, you have to include Firebase Database dependency in your project.
And, insert in your project.

1. Make sure, you've valid Project in your Firebase Console.
2. Import *GoogleService-Info.plist* which you'll get from your Firebase console.

```swift

import FirebaseDatabase

```

### Create Database Reference
Before using database, you need a Firebase Database reference. And, with that reference you can create read/write operation. 

```swift

let reference = Database.database().reference()

```

### Create Unique Key

```swift



```

### Write to Database


### Read to Database
