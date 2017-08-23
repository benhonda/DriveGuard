# DriveGuard
A framework that manages the functionality of an app while the user is suspected to be driving an automobile.

DriveGuard only works with devices that have at least the M7 motion co-processor. These devices include the iPhone 5s, iPad Air, iPad Mini 2, Apple A7 and all devices following these ones (e.g. iPhone 6, iPhone 7, iPad Air 2, etc.)

The full device list can be found here:
[https://en.wikipedia.org/wiki/Apple_motion_coprocessors](https://en.wikipedia.org/wiki/Apple_motion_coprocessors "Apple Motion Coprocessors")

## Features
```
func userIsDriving(driving: Bool)
--> returns a Bool value either true (user is currently driving) or false and a completion block
```

```
func userIsDrivingCustomAlert(viewController: UIViewController, alertTitle: String, alertMessage: String, alertActionTitle: String?, completion: (() -> ())? = nil) 
--> displays a UIAlert with the text provided
```

```
func userIsDrivingProhibitedAlert(viewController: UIViewController, completion: (() -> ())? = nil)
--> displays a UIAlert with generic text saying driving is prohibited while using the app (see screenshots fig. 1)
```

```
func userIsDrivingDiscouragedAlert(viewController: UIViewController, completion: (() -> ())? = nil)
--> displays a UIAlert with generic text saying driving is discouraged, but not prohibited while using the app (see screenshots fig. 2)
```

## Installation

#### DriveGuard will require your app to gain permission from the user to access their device's accelerometer. This is done by adding a NSMotionUsageDescription key to your app's Info.plist. Without it, your app will crash.

1. Copy this line (feel free to put whatever you like within the `<string></string>` delimiters. This is the message that the user is prompted with when they first use your app):
```
<key>NSMotionUsageDescription</key>
  <string>$(PRODUCT_NAME) requires access to the device's accelerometer in order to function optimally</string>
```

2. Open your app's Info.plist file as 'Source Code' by right-clicking on the Info.plist in XCode and selecting Open As -> Source Code

3. Paste the line you copied from step 1 anywhere inside the `<dict></dict>` delimiters.

4. Right click on 'Info.plist' again and select Open As -> Property List and you should see your new field named something like 'Privacy - Motion Usage Description'. If not, make sure you pasted the line from step 1 within the `<dict></dict>` delimiters.

### Now you may begin

As of version 0.0.1, the best (and only) way to install DriveGuard into your application is to download the .zip file and drag the 'DriveGuard.xcodeproj' directly into your app. Follow these easy steps and I'll walk you through it. Also, if you haven't already, you need to add an NSMotionUsageDescription key to your app's 'Info.plist' file. The instructions for doing that are above.

1. Select the 'Clone or Download Zip' button and download the .zip file anywhere on your computer.

2. Open the .zip file, and locate the file named 'DriveGuard.xcodeproj'.

3. Open your project in XCode. In the Project Navigator on the left side of XCode, drag and drop the file 'DriveGuard.xcodeproj' into your project.

4. Click on your project at the top of the Project Navigator, which is named whatever the name of your app is, and under General -> Embedded Binaries click '+' to add a new binary. Under 'DriveGuard.xcodeproj' -> Products select the framework 'DriveGuard.framework'. Hit 'Add'.

5. That's it! To begin using DriveGuard in your project, simply go into your desired view controller and import the framework by adding this line to the top of your code:

```
import DriveGuard
```

Then, add an instance of the class and you're good to go:

```
let driveGuard = DriveGuard()
```

## Example

Check if the user is driving
```
override func viewDidAppear(_ animated: Bool) {
        
    // create an instance of the DriveGuard class
    let drive = DriveGuard()

    // check if the user is driving...
    // 'driving' is a Boolean variable... true if the user is driving
    drive.userIsDriving { (driving) in

        if driving {

            // The user is driving
            print("You're driving!")

        } else {

            // The user is not driving
            print("You're good to go.")

        }

    }
        
}
```

Check if the user is driving, then display an alert
```
override func viewDidAppear(_ animated: Bool) {
        
    // create an instance of the DriveGuard class
    let drive = DriveGuard()

    // if the user is driving, display a 'driving is prohibited' alert
    drive.userIsDrivingProhibitedAlert(viewController: self) { (action) in

        // action #1 is the close button (the left-most button)
        if action == 1 {

            print("Close")

        }

        // action #2 is the Passenger button (the right-most button)
        if action == 2 {

            print("Passenger")

        }

    }

}
```

## Note
When using one of the default functions that use UIAlerts, it's better to put the code inside the `viewDidAppear` function rather than the `viewDidLoad` function. Otherwise your program may throw a `Warning: Attempt to present ... whose view is not in the window hierarchy!` error... we're working on that.

## Error Handling
For devices who do not have at least the M7 Motion Coprocessor (this includes the simulator by the way), DriveGuard will give you the error: `The activity moniter is not available. DriveGuard requires at least the M7 motion co-processor. It appears this device does not have the hardware needed. For more information please visit the DriveGuard Github page at www.github.com/benhonda/DriveGuard` This prevents your app from crashing, but DriveGuard won't be able to tell if the user is driving or not. We're working on that too.

## License
MIT. Do what you will.

### Comments and Concerns
If have anything to say, questions or comments, please do not hesitate to contact me.
