import Fluent

public protocol Liker: Model {}

extension Liker {
    public func like<Target: Likeable>(
        _ target: Target,
        on database: Database
    ) async throws
        where Target.LikedBy == Self
    {
        try await Like<Target>(likerID: requireID(), targetID: target.requireID()).create(on: database)
    }
    
    public func unlike<Target: Likeable>(
        _ target: Target,
        on database: Database
    ) async throws
        where Target.LikedBy == Self
    {
        try await QueryBuilder<Like<Target>>(database: database)
            .filter(\.$target.$id == target.requireID())
            .filter(\.$liker.$id == requireID())
            .delete()
    }
    
    public func likes<Target: Likeable>(
        _ target: Target,
        on database: Database
    ) async throws -> Bool
        where Target.LikedBy == Self
    {
        try await QueryBuilder<Like<Target>>(database: database)
            .field(\.$id)
            .filter(\.$target.$id == target.requireID())
            .filter(\.$liker.$id == requireID())
            .first()?.id != nil
    }
}
