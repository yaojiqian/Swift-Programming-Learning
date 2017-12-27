# Swift-Programming-Learning
Learning Swift Programming

This repository is to leaning the Swift iOS programming.

## Adding Behavior
### Gravity Behavior
Adding gravity behavior	to UIComponent.
A behavior is a property of an animator, and the animator can contain some items - view components. the view components can be add to different animators at same time. 

### Push Behavior
Adding push behavior.
create a view and place it at the center of our view controller’s view. incorporate a collision behavior into our animator, which will prevent our little view from going outside the bounds of our view controller’s view.

### Attachment Behavior
attachmentBehavior = UIAttachmentBehavior(item: squareView!, offsetFromCenter: UIOffset(horizontal: 30, vertical: -40) , attachedToAnchor: anchorView!.center)
Here the item of the UIAttachmentBehavior is the item which will follow the attachedToAnchor. in this example, it’s the squareView, not the anchorView. the anchorView indicates the anchor point.

### Snap Behavior


### Dynamic Item Behavior
elasticity, friction, density, allowRotation, resistance…


## Table View

### Populating a TableView with Data
Implement TableViewSource class conform the UITableViewDataSource protocol.
numberOfSections returns the total sections of the table view.
tableView:numberOfRowsInSection returns the count of the rows for each section.
tableView:cellForRowAt creates tableview cell using tableview’s dequeueReusableCell method. And give the title.

### Enabling Swipe Deletion of Table View Cells
Implement UITableViewDelegate on ViewController.
	tableView:editiingSytleForRowAt
override Viewcontroller’s setEditing:animated, call tableView’s setEditing:animated

TableViewDataSource, add UITableViewDatasource’s tableView:commit:forRowAt to remove the row from the data source.

### Constructing Headers and Footers in Table Views
tableView:viewForHeaderInSection
tableView:viewForFooterInSection
tableView:heightForHeaderInSection

### Displaying a Refresh Control for Table Views
class UIRefreshControl : UIControl
Description	
A UIRefreshControl object provides a standard control that can be used to initiate the refreshing of a table view’s contents. You link a refresh control to a table through an associated table view controller object. The table view controller handles the work of adding the control to the table’s visual appearance and managing the display of that control in response to appropriate user gestures.
Note
Because the refresh control is specifically designed for use in a table view that's managed by a table view controller, using it in a different context can result in undefined behavior.

### Providing Basic Content To a Collection View
UICollectionViewFlowlayout

### Feeding Custom Cells to Collection Views Using .xib Files
Add a .xcassets to project: File->New->File, select ‘Asset Catalog’ from Resource tab.

Add UICollectionViewCell subclass: File->New->File, select ‘Cocoa Touch Class’, then give the Class name, and Subclass of. Here is also option to select Language.

let nib = UINib(nibName: "MyCollectionViewCell", bundle: nil)
collectionView?.register(nib, forCellWithReuseIdentifier: "Cell") 
these two lines, make the .xib bound to class.

### Handling Events in Collection Views
UICollectionViewCell has a selectedBackgroundView property, To change the selected cell’s background, just set the selectedBackgroundView’s backgroundColor.

collectionView:didSelectItemAt, Tells the delegate that the item at the specified index path was selected.

collectionView:didHighlightItemAt, Tells the delegate that the item at the specified index path was highlighted.

collectionView:didUnhighlightItemAt, Tells the delegate that the highlight was removed from the item at the specified index path.

UIView.animate:withDuration:animations:, Animate changes to one or more views using the specified duration.

### Providing Header and Footer in a Collection ViewAdd Header and Footer classes which derive from UICollectionReusableView.
In ViewController’s init:collectionViewLayout, register collectionView, header and footer.
In ViewController’s init:coder, set layout’s headerReferenceSize and footerReferenceSize.
Override collectionView:_collectionView:viewForSupplementaryElementOfKind:at, set header or footer’s properties then return it.


### Adding Custom Interactions to Collection Views
The iOS API has already added a few gesture recognizers to collection views. So in order to add your own gesture recognizers on top of the existing collection, you first need to make sure that your gesture recognizers will not interfere with the existing ones. To do that, you have to first instantiate your own gesture recognizers and, as explained before, look through the existing array of gesture recognizers on the collection view and call the requireGestureRecognizerToFail: method on the one that is of the same class type of gesture recognizer as the one you are attempting to add to the collection view.    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        
        for recognizer in (collectionView?.gestureRecognizers!)!{
            if recognizer is UIPinchGestureRecognizer{
                recognizer.require(toFail: pinch)
            }
        }
        
        collectionView?.addGestureRecognizer(pinch)
    }
    
    func handlePinch(pinch: UIPinchGestureRecognizer){
        let defaultLayoutItemSize = CGSize(width: 80, height: 120)
        let layout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize =
            CGSize(width: defaultLayoutItemSize.width * pinch.scale,
                   height: defaultLayoutItemSize.height * pinch.scale)
        layout.invalidateLayout()
    }


## Concurrency and Multitasking
Grand Central Dispatch, or GCD for short, is a low-level C API that works with block objects. The real use for GCD is to dispatch tasks to multiple cores without making you, the programmer, worry about which core is executing which task. On Mac OS X, mul‐ ticore devices, including laptops, have been available to users for quite some time. With the introduction of multicore devices such as the new iPad, programmers can write amazing multicore-aware multithreaded apps for iOS.

### Performing UI-Related Tasks
Use the dispatch_get_main_queue function.
UI-related tasks have to be performed on the main thread, so the main queue is the only candidate for UI task execution in GCD. We can use the dispatch_get_main_queue function to get the handle to the main dispatch queue.The correct way to dispatch tasks to the main queue is by using the dispatch_async function, which executes a block object on a dispatch queue.
```
        DispatchQueue.main.async{ [weak self] in
            let alertController = UIAlertController(title: "GCD", message: "GCD is amazing", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self?.present(alertController, animated: true, completion: nil)
        }
```

**DispatchQueue.main.async** execute a block on the *main dispatch queue*.
**Thread.current** gets the current thread, **Thread.main** gets the main thread.

### Performing Non-UI Related Tasks
For any task that doesn’t involve the UI, you can use **global concurrent queues** in GCD. These allow either *synchronous* or *asynchronous* execution. But synchronous execution does not mean your program waits for the code to finish before continuing. It simply means that the *concurrent queue* will wait until your task has finished before it continues to the next block of code on the queue. 

### Performing Tasks After a Delay
asyncAfter need a deadline time, not the time interval. So the deadline parameter should be a future time point. example:
	let deadLine = DispatchTime.now() + DispatchTimeInterval.seconds(10)

### Performing a Task Only Once
Dispatch Once is replaced with global or static constants and variables.

### Grouping Tasks Together
Use DispatchGroup() to create a task group. Then indicates the task group while call DispatchQueue’s async as the first parameter.
To receive the notification from task group, call the task group’s notify method.
    override func viewDidLoad() {
        super.viewDidLoad()

        let taskGroup = DispatchGroup()
        let mainQueue = DispatchQueue.main
        
        /* Reload the table view on the main queue */
        mainQueue.async(group: taskGroup, execute: {[weak self] in self!.reloadTableView() })
        /* Reload the scroll view on the main queue */
        mainQueue.async(group: taskGroup, execute: {[weak self] in self!.reloadScrollView()})
        /* Reload the image view on the main queue */
        mainQueue.async(group: taskGroup, execute: {[weak self] in self!.reloadImageView() })
        
        /* When we are done, dispatch the following block */
        taskGroup.notify(queue: mainQueue, execute: {[weak self] in
            let alertController = UIAlertController(title: "task group", message: "all task have done!", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title:"OK", style:.default, handler: nil))
            
            self!.present(alertController, animated:true, completion:nil)
        })

### Creating Simple Concurrency with Operations
define a subclass of Operation, override the main method. create a object of this Operation and create OperationQueue, then add the operation to the operationQueue.

Here found that the current thread is different from main thread:
count:3
current thread:<NSThread: **0x60000026b7c0**>{number = 3, name = (null)}
main thread:<NSThread: **0x6000002636c0**>{number = 1, name = (null)}

Another way to work with operation is using **BlockOperation** class instead of creating subclass of Operation.

maxConcurrentOperationCount - readable and writable

### Creating Dependency Between Operations
If operation B has to wait for operation A before it can run the task associated with it, operation B has to add operation A as its dependency using the **addDependency**: in‐ stance method of Operation.

        let firstNumber = 111
        let secondNumber  = 222
        
        let firstOperation = BlockOperation(block: {[weak self] in
            if let strongSelf = self{
                strongSelf.firstOperationEntry(param: firstNumber as AnyObject)
            }
        })
        
        let secondOperation = BlockOperation(block: {[weak self] in
            if let strongSelf = self{
                strongSelf.secondOperationEntry(param: secondNumber as AnyObject)
            }
        })
        
        let operationQueue = OperationQueue()
        
        firstOperation.addDependency(secondOperation)
        
        operationQueue.addOperation(firstOperation)
        operationQueue.addOperation(secondOperation)


### Firing Periodic Tasks
Once a timer is created and added to a run loop, you can stop and release that timer using the invalidate instance method of the NSTim er class. This not only releases the timer, but also the object, if any, that was passed for the timer to retain during its lifetime (e.g., the object passed to the userInfo parameter of the scheduledTimer WithTimeInterval:target:selector:userInfo:repeats: class method of Timer). If you pass false to the repeats parameter, the timer invalidates itself after the first pass and subsequently releases the object it had retained (if one exists).

### Completing a Long-Running Task in the Background
When an iOS application is sent to the background, its main thread is paused. The threads you create within your application are also suspended. 
To borrow some rime from iOS, the **beginBackgroundTaskWithName:expirationHandler:** instance method of UIApplication must be called.


### Adding Background Fetch Capabilities to Your Apps
go to the Capabilities tab of the project settings, and under the Background Modes slice, enable the **“Background fetch”** item

call setMinimumBackgroundFetchInterval to ask iOS to wake up your app in the background and ask it to fetch new data. 
implement the application:performFetch WithCompletionHandler: instance method of your app delegate.
NotificationCenter.default.addObserver(self, selector: #selector(handleNewsItemsChanged), name: NSNotification.Name(rawValue: AppDelegate.newsItemsChangedNotification()), object: nil), register NotificationCenter Observer.

### Playing Audio in the Background



### Handling Location Changes in the Background
CLLocationManager telling you when iOS detects that the device is at a new location. 

### Handling Network Connections in the Background


## Security

### Authenticating the User with Touch ID
Use the **LocalAuthentication** framework in your application.
LAContext’s canEvaluatePolicy to check the availability of Touch ID.
evaluatePolicy:localize dReason:reply:

## Core Location, iBeacon, and Maps
The Core Location and Map Kit frameworks can be used to create location-aware and map-based applications. The Core Location framework uses the device’s internal hard‐ ware to determine the current location of the device. The Map Kit framework enables your application to display maps to your users, put custom annotations on the maps, and so on. 

### Detecting Which Floor the User Is on in a Building

        manager = CLLocationManager()
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()

Implements the CLLocationManagerDelegate’s func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])

Info.plist add Privacy - Location Always Usage Description (NSLocationAlwaysUsageDescription)

### Defining and Processing iBeacons
use the CBPeripheralManager class to ensure that Bluetooth is turned on.
Source app implements CBPeripheralManagerDelegate.
Destination app implements CLLocationManagerDelegate.

### Pinpointing the Location of a Device

	/* Are location services available on this device? */
        if CLLocationManager.locationServicesEnabled() {
            
            /* Do we have authorization to access location services? */
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways:
                /* Yes, always. */
                createLocationManager(startImmediately: true)
            case .authorizedWhenInUse:
                /* Yes, only when our app is in use. */
                createLocationManager(startImmediately: true)
            case .denied:
                /* No. */
                displayAlertWithTitle(title: "Not Determined", message: "Location services are not allowed for this app")
            case .notDetermined:
                /* We don't know yet; we have to ask */
                createLocationManager(startImmediately: false)
                if let manager = locationManager {
                    manager.requestWhenInUseAuthorization()
                }
            case .restricted:
                /* Restrictions have been applied; we have no access to location services. */
                displayAlertWithTitle(title: "Restricted",  message: "Location services are not allowed for this app")
            }
        }

### Displaying Pins on a Map View
1. Create a new class, subclassing NSObject, and call it MyAnnotation.2. Make sure this class conforms to the MKAnnotation protocol.3. Define a property for this class of type CLLocationCoordinate2D and name it coordinate. Make sure you set it as a readonly property because the coordinate property is defined as readonly in the MKAnnotation protocol.4. Optionally, define two properties of type NSString, namely title and subtitle, which can carry the title and the subtitle information for your annotation view. Both of these properties are readonly as well.5. Create an constructor method for your class that accepts a parameter of type CLLocationCoordinate2D. In this method, assign the passed location parameter to the property that we defined in step 3. Because this property is readonly, it cannot be assigned by code outside the scope of this class. Therefore, the constructor of this class acts as a bridge here and allows us to indirectly assign a value to this property. We will do the same thing for the title and subtitle properties.6. Instantiate the MyAnnotation class and add it to your map using the addAnnotation: method of the MKMapView class.

### Displaying Custom Pins on a Map View

The delegate of the map view gets called on its mapView:viewForAnnotation: method and is given a chance to provide a custom annotation view to be displayed on the map view. 

To display the Custom Image, should create a new MKAnnotatioView object instead of MKPinAnnotationView.

        if senderAnnotation.pinColor == .Blue{
            let pinImage = UIImage(named: "BluePin")
            let blueAnnotationView = MKAnnotationView(annotation: senderAnnotation, reuseIdentifier: pinReusableIdentifier)
            blueAnnotationView.canShowCallout = true
            blueAnnotationView.image = pinImage
            return blueAnnotationView
        }else{
            annotationView!.pinTintColor = senderAnnotation.pinColor?.toPinColor()
        }

### Searching on a Map View
MKLocalSearchRequest, MKLocalSearch, MKLocalSearchResponse.
mapView:didFailToLocateUserWithError:
mapView:didUpdateUserLocation:
MKMapItem
	
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "restaurant"
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        request.region = MKCoordinateRegion(center: (userLocation.location?.coordinate)!, span: span)
        
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: {
            (response: MKLocalSearchResponse?, error: Error?) in
            for item in (response?.mapItems)! {
                print("item name = \(item.name ?? " ")")
                print("Item phone number = \(item.phoneNumber ?? " ")")
                print("Item url = \(String(describing: item.url))")
                print("Item location = \(String(describing: item.placemark.location))")
            }
        } )
    }


### Displaying Directions on the Map
Directions to walk or drive can be displayed only in the Maps app on a device, so you cannot display them inside an instance of a map view in your app. 
MKDirections, calculateDirectionsWithCompletionHandler: , MKDirectionsResponse

	/* Get the directions */	let directions = MKDirections(request: request)
	directions.calculateDirectionsWithCompletionHandler{		(response: MKDirectionsResponse!, error: NSError!) in          /* You can manually parse the response, but in          here we will take a shortcut and use the Maps app          to display our source and          destination. We didn't have to make this API call at all,          as we already had the map items before, but this is to          demonstrate that the directions response contains more          information than just the source and the destination. */          /* Display the directions on the Maps app */
	let launchOptions = [ MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
	MKMapItem.openMapsWithItems(            [response.source, response.destination],            launchOptions: launchOptions)


### Customizing the View of the Map with a Camera
locationManager is required.

## Gesture Recognizers
Gestures are a combination of touch events. Gesture recognizers are divided into two categories: discrete and continuous. Discrete gesture recognizers detect their gesture events and, when detected, call a method in their respective owners. Continuous gesture recognizers keep their owner objects informed of the events as they happen and call the method in their target object repeatedly as the event happens and until it ends.
	• Swipe	• Rotation	• Pinch	• Pan	• Long-press 
	• Tap

The basic framework for handling a gesture through a built-in gesture recognizer is as follows:
	1. Create an object of the right data type for the gesture recognizer you want.	2. Add this object as a gesture recognizer to the view that will receive the gesture.	3. Write a method that is called when the gesture occurs and that takes the action you want.
The method associated as the target method of any gesture recognizer must follow these rules:	• It must return void.	• It must either accept no parameters, or accept a single parameter of type UIGestureRecognizer in which the system passes the gesture recognizer that calls this method.

Discrete gesture recognizers can pass through the following states:1. UIGestureRecognizerStatePossible 2. UIGestureRecognizerStateRecognized 3. UIGestureRecognizerStateFailed

Continuous gesture recognizers take a different path in the states they send to their targets:1. UIGestureRecognizerStatePossible 2. UIGestureRecognizerStateBegan 3. UIGestureRecognizerStateChanged 4. UIGestureRecognizerStateEnded 5. UIGestureRecognizerStateFailed

### Detecting Swipe Gestures
One UISwipeGestureRecognizer object can only recognize one direction swipe. so if want to two direction swipes, should create two UISwipeGestureRecognizers.
.direction
.numberOfTouchesRequired

### Detecting Rotation Gestures
UIRotationGestureRecognizer

    func handleRotation(recognizer : UIRotationGestureRecognizer){
        /* Take the previous rotation and add the current rotation to it */
        helloWorldLabel.transform = CGAffineTransform(rotationAngle: rotationAngleInRadians + recognizer.rotation)
        
        /* At the end of the rotation, keep the angle for later use */
        if recognizer.state == .ended{
            rotationAngleInRadians += recognizer.rotation
        }        
    }

### Detecting Panning and Dragging Gestures


### Detecting Long Press Gestures

### Detecting Tap Gestures

### Detecting Pinch Gestures

### Detecting Screen Edge Pan Gestures


## Networking and Sharing

### Downloading Data Using NSURLSession
the **NSURLSessionConfiguration** class configures session. **NSURLSessionDelegate**, **NSURLSession** and **NSURLSessionDataTask** or **NSURLSessionDownTask** work together to download data.
Bear in mind that after every task that you create with a URL session, you need to call the **resume** method on that task to start it.
