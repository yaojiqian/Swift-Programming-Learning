//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

print(str)

let count:Int = 10

var sum:Int = 0
for var i = 0; i <= count; i++ {
    sum += i
}

print("the sum is \(sum)")

let arrNames:[String] = ["Tom", "Jerry", "Ketty", "Jeff"]

print(arrNames)

for name in arrNames{
    print("Hello \(name)")
}

let dirIntString:[Int:String] = [1:"Tom", 2:"Jeff", 3:"Ketty"]
print("Hello \(dirIntString[1])")
print("Hello \(dirIntString[2])")
print("Hello \(dirIntString[3])")
print("Hello \(dirIntString[4])")

let dirStringInt:[String:Int] = ["Tom":12, "Jeff":23, "Ketty":99]
var tomValue = dirStringInt["Tom"]
print("the value Tom is \(tomValue)")

//greet("Bob", "Tuesday")

func greet(name:String, day:String)->String{
    return "Hello \(name), today is \(day)."
}
greet("Bob", day: "Tuesday")

func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int){
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores{
        if score < min {
            min = score
        }
        if score > max {
            max = score
        }
        sum += score
    }
    return (min, max, sum)
}

let statistics = calculateStatistics([5, 3, 100, 3, 9])

statistics.sum
statistics.min
statistics.max
statistics.2

func sumOf(numbers: Int...)->Int{
    var sum = 0
    for num in numbers{
        sum += num
    }
    return sum
}

sumOf(24, 43, 57)
sumOf(45, 2, 33, 99, 1, 100)

func returnFifteen()->Int {
    var y = 10
    func add(){
        y += 5
    }
    add()
    return y
}

returnFifteen()

func makeIncrementer()->(Int ->Int){
    func addOne(number: Int)->Int{
        return 1 + number
    }
    return addOne
}

var increment = makeIncrementer()
increment(7)

func hasAnyMatches(list: [Int], condition:(Int->Bool))->Bool{
    for item in list{
        if condition(item) {
            return true
        }
    }
    return false
}

func lessThanTen(number: Int)-> Bool{
    return number < 10
}

func moreThanTen(number: Int)->Bool{
    return number > 10
}

var numbers = [20, 10, 17, 3]
hasAnyMatches(numbers, condition: {
    (num:Int)->Bool in
    return num == 10
})

let numberMap = numbers.map({
    num in 3 * num
})

print(numberMap)

let sortedNumbers = numbers.sort({$0 > $1})
print(sortedNumbers)


class Shape {
    let name = "Shape"
    var numberOfSides = 0
    func simpleDescription()->String{
        return "A Shape with \(numberOfSides) sides."
    }
    private func privateFun(str: String)->String{
        return "privateFun \(str)"
    }
}

var aShape = Shape()
aShape.numberOfSides = 3
aShape.simpleDescription()
var privateCall = aShape.privateFun("KKK")

class NamedShape
{
    var name:String
    var numberOfSide:Int = 0
    
    init()
    {
        name = "NamedShape"
        numberOfSide = 0
    }
    
    func description()->String
    {
        return "the \(name) shape"
    }
}

class Triangle: NamedShape
{
    override init()
    {
        super.init()
        name = "Triangle"
        numberOfSide = 3
    }
    private func pfunc()->String
    {
        return "the private func of Triangle."
    }
}

let t = Triangle()
t.description()
t.pfunc()





