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