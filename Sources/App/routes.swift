import Vapor

struct User: Content {
    var bool:Bool = true
    var int:Int = 12
    var int8:Int8 = 2
    var double:Double = 6.1
    var float:Float = 3.1
    var name: String = "Vapor User"
    var email: String = "user@vapor.codes"
}
/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("_hello") { req in
        return "Hello, world!"
    }
    router.get("hello") { req -> Future<String> in
        let promise = req.eventLoop.newPromise(Void.self)
        DispatchQueue.global().async {
            sleep(5)
            promise.succeed()
        }
        return promise.futureResult.transform(to: "Hello, world!")
    }
    router.group("test") { (router) in
        router.get("ads") { (req) -> User in
            return User()
        }
        
    }
    
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}
