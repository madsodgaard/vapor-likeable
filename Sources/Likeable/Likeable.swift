import Vapor
import Fluent
import Foundation

public protocol Likeable: Model {
    associatedtype LikedBy: Liker
}

extension Likeable {
    public func likes(on database: Database) throws -> QueryBuilder<Like<Self>> {
        try QueryBuilder<Like<Self>>(database: database).filter(\.$target.$id == requireID())
    }
}
