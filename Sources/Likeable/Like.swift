import Fluent
import Foundation

public final class Like<Target: Likeable>: Model {
    public static var schema: String { "\(Target.self)_likes".lowercased() }
    
    @ID
    public var id: UUID?
    
    @Parent(key: "liker_id")
    public var liker: Target.LikedBy
    
    @Parent(key: "target_id")
    public var target: Target
    
    @Timestamp(key: "liked_at", on: .create)
    public var likedAt: Date?
    
    public init() {}
    
    public init(
        id: UUID? = nil,
        likerID: Target.LikedBy.IDValue,
        targetID: Target.IDValue,
        likedAt: Date? = nil
    ) {
        self.id = id
        self.$liker.id = likerID
        self.$target.id = targetID
        self.likedAt = likedAt
    }
}
