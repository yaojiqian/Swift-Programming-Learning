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


