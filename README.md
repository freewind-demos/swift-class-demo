# Swift 类 Demo

## 简介

本 demo 展示 Swift 类的创建、继承、引用类型特点。类是 Swift 中**面向对象编程**的核心，和结构体（struct）一样都能定义属性和方法，但有重要的区别。

## 基本原理

### 类 vs 结构体

Swift 中类和结构体非常相似：

```swift
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

struct PersonStruct {
    var name: String
    var age: Int

    func introduce() {
        print("我叫 \(name)，今年 \(age) 岁")
    }
}
```

但两者有**根本区别**：

| 特性 | 类 (class) | 结构体 (struct) |
|------|-----------|----------------|
| 类型 | 引用类型 | 值类型 |
| 继承 | 支持 | 不支持 |
| 引用计数 | 有 (ARC) | 无 |
| 析构器 | 支持 | 不支持 |
| mutating | 不需要 | 需要修改属性时需要 |

### 引用类型 vs 值类型

**结构体是值类型**：
- 赋值时会复制整个对象
- 每个实例有独立的数据

**类是引用类型**：
- 赋值时只复制引用（指向同一块内存）
- 多个变量可以指向同一个实例

```swift
// 类 - 引用类型
class Student {
    var name: String
    init(name: String) {
        self.name = name
    }
}

let s1 = Student(name: "Alice")
let s2 = s1  // s2 指向同一个对象
s2.name = "Bob"
print("s1.name = \(s1.name)")  // 输出: "Bob"！

// 结构体 - 值类型
struct StudentStruct {
    var name: String
}

var ss1 = StudentStruct(name: "Alice")
var ss2 = ss1  // ss2 是独立的副本
ss2.name = "Bob"
print("ss1.name = \(ss1.name)")  // 输出: "Alice"
```

### 引用计数 (ARC)

Swift 使用**自动引用计数（ARC）**来管理类的内存：

```swift
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) 创建")
    }
    deinit {
        print("\(name) 销毁")
    }
}

var p1: Person?
var p2: Person?
var p3: Person?

p1 = Person(name: "Tom")  // ARC = 1
p2 = p1                    // ARC = 2
p3 = p1                    // ARC = 3

p1 = nil  // ARC = 2
p2 = nil  // ARC = 1
p3 = nil  // ARC = 0，对象被销毁
```

---

## 启动和使用

### 环境要求

- Swift 5.0+
- macOS 或 Linux

### 安装和运行

```bash
cd swift-class-demo
swift run
---

## 教程

### 定义类

```swift
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
```

### 类的引用类型特性

```swift
class Student {
    var name: String
    init(name: String) {
        self.name = name
    }
}

let s1 = Student(name: "Alice")
let s2 = s1  // 共享同一个对象
s2.name = "Bob"
print("s1.name = \(s1.name)")  // 输出: "Bob"
```

### 继承

类可以继承其他类：

```swift
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
dog.speak()  // 输出: "旺财 汪汪叫"
```

### 构造器

类的构造器用于初始化实例：

```swift
class Point {
    var x: Double
    var y: Double

    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }

    // 便利构造器
    convenience init() {
        self.init(x: 0, y: 0)
    }
}

let p1 = Point(x: 1, y: 2)
let p2 = Point()  // 使用便利构造器
```

### 惰性属性 (lazy)

`lazy` 属性延迟初始化，只在首次访问时才计算：

```swift
class DataManager {
    lazy var data: [String] = {
        print("加载数据...")  // 首次访问时打印
        return ["a", "b", "c"]
    }()
}

let manager = DataManager()
print("准备访问数据")  // 不会打印"加载数据"
print("数据: \(manager.data)")  // 首次访问，打印"加载数据..."
```

**使用场景**：
- 初始化成本高的属性
- 依赖其他属性的属性
- 只在特定条件下需要的属性

---

## 关键代码详解

### 引用类型的内存布局

```
s1 ────┐
       ├──► [name: "Bob"]  (堆内存)
s2 ────┘
```

多个变量指向同一个对象实例，修改一个会影响所有引用。

### 惰性属性的原理

```swift
lazy var data: [String] = { ... }()
```

编译器会生成类似这样的代码：
```swift
private var _data: [String]?

var data: [String] {
    if let _data = _data {
        return _data
    }
    _data = { ... }()
    return _data!
}
```

---

## 总结

类是 Swift 面向对象编程的核心：

1. **引用类型** — 赋值时共享引用
2. **继承** — 支持类层次结构
3. **ARC** — 自动内存管理
4. **析构器** — 释放资源
5. **惰性加载** — 延迟初始化

什么时候用类：
- 需要继承
- 需要引用语义（共享状态）
- 需要析构器清理资源
- 对象生命周期需要明确管理

什么时候用结构体：
- 不需要继承
- 需要值语义（独立副本）
- 简单数据结构
- 追求 immutability
