// swift-class-demo.swift

// ============ 基本类 ============
class Person {
    var name: String
    var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    func introduce() {
        print("我叫 \(name)，今年 \(age) 岁")
    }
}

let person = Person(name: "Tom", age: 25)
person.introduce()

// ============ 类作为引用类型 ============
class Student {
    var name: String
    init(name: String) {
        self.name = name
    }
}

let s1 = Student(name: "Alice")
let s2 = s1  // 共享同一个对象
s2.name = "Bob"
print("s1.name = \(s1.name)")  // 打印 "Bob"

// ============ 惰性属性 ============
class DataManager {
    lazy var data: [String] = {
        print("加载数据...")
        return ["a", "b", "c"]
    }()
}

let manager = DataManager()
print("准备访问数据")
print("数据: \(manager.data)")

// ============ 继承 ============
class Animal {
    var name: String

    init(name: String) {
        self.name = name
    }

    func speak() {
        print("\(name) 发出了声音")
    }
}

class Dog: Animal {
    override func speak() {
        print("\(name) 汪汪叫")
    }
}

let dog = Dog(name: "旺财")
dog.speak()

// ============ 便利构造器 ============
class Point {
    var x: Double
    var y: Double

    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }

    convenience init() {
        self.init(x: 0, y: 0)
    }
}

let p1 = Point(x: 1, y: 2)
let p2 = Point()
print("p1: (\(p1.x), \(p1.y))")
print("p2: (\(p2.x), \(p2.y))")
