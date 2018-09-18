import Vapor

/// Called after your application has initialized.
public func boot(_ app: Application) throws {
    let client = try app.make(Client.self)
    
    let time = Date().timeIntervalSince1970
    let res = try client.get("http://vapor.codes").wait()
    print(res)
    print(Date().timeIntervalSince1970 - time)
}
