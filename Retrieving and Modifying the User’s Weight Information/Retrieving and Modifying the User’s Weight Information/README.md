

TextField 有两个属性，rightView和leftView。可以在TextFiled的后部和前部显示。
textField.rightView = textFieldRightLabel
textField.rightViewMode = .always
像这样可以把一个Label赋值给TextField的rightView。

NSHealthUpdateUsageDescription
NSHealthShareUsageDescription

HKSampleQuery定义一个query
调用HKHealthStore的executeQuery，参数为query。

HKHealthStore的save,可以用来保存数据。

read height information.


Issue:
no rule to process file '/Users/yaojiqian/Documents/Swift-Programming-Learning/Retrieving and Modifying the User’s Weight Information/Retrieving and Modifying the User’s Weight Information/README.md' of type text for architecture x86_64
Solustion:
remove README.md from product Retrieving and Modifying the User's Weight Information

尝试添加Retoration，但是似乎没有成功。
已经改了：AppDelegate：
        application _ application: shouldSaveApplicationState
        application _ application: shouldRestoreApplicationState
ViewController：
    override func encodeRestorableState(with coder: NSCoder)
    override func decodeRestorableState(with coder: NSCoder)
ViewController也已经设置的Restoraction ID


