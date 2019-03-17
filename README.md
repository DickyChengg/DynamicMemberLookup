# Dynamic Member Lookup

Examples of how to use `@dynamicMemberLookup` for `Dictionary`, and `String Localization`, `Json Model Mapper`.

Note: This `@dynamicMemberLookup` only available in swift 4.2 or above.

Dynamic Dictionary
----

Swift Dictionary:
```
var data: [String: Any] = [:]
data["name"] = "John"
data["age"] = 10

let name: String? = data["name"] as? String
let age: Int? = data["age"] as? Int

print(name) // optional("John")
print(age)  // optional(10)
```

With Dynamic Dictionary:
```
let data = DynamicMap()
data.name = "John"
data.age = 10
```

To get the value, you dan do it like this:
```
let name: String? = data.name
let age: Int? = data.age

print(name) // optional("John")
print(age)  // optional(10)
```
or
```
var name: String?
var age: Int?

name <= data.name
age <= data.age
```

Dynamic Localization
----

For example if we have a json like this and we want to get the string based on the key,   
we can do it simply by create an instance of Localization and use it like this:
```
let json: [String: String] = [
  "title": "Welcome to Dynamic Localization Example."
  "description": "You can use Localization class to load this string."
]

let R: Localization = Localization(json: json)

let title: String = R.title
let desc: String = R.description
let other: String = R.other // fatalError("Key not found")

print(title) // "Welcome to Dynamic Localization Example."
print(desc)  // "You can use Localization class to load this string."

```

You also can build the string that are combination of string and API response.
```
let json: [String: String] = [
  "total_fruit": "I have @{total} @{fruit}@{more} in my bag."
]

let R: Localization = Localization(json: json)

// Assume we already get the response.
let total: Int = 5
let fruitName: String = "apple"
let more: String = total > 1 ? "s" : ""

let totalFruit: String = R.totalApple
    .set("total", with: "\(total)")
    .set("fruit", with: fruitName)
    .set("more", with: more)
    .value

print(totalFruit) // "I have 5 apples in my bag."
```
When you didn't set the key, this `@{...}` will be replaced   
by empty string automatically when you call `.value` property.

Json Model Mapper
----

For example you have a model class like this and you want to convert the response to this model.
```
final class User: Mappable {
  var name: String = ""
  var age: Int = 0
  var height: Double = 0

  required init() { }

  required init(map: Map) {
    name = map.name
    age = map.age
    height = map.height
  }
}

let json: [String: Any?] = [
  "name": "John Doe",
  "age": 100,
  "height": 170.5
]
let model = User(map: json)

print(model.name)   // "John Doe"
print(model.age)    // 100
print(model.height) // 170.5
```
This JSON Model Converter also support chaining variable.

If you want to try all of this by yorself, you can clone this project.   
Thankyou!!   
:))
