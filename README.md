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
