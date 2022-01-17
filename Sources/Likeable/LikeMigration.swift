import Fluent

public struct LikeMigration: AsyncMigration {
    public var name: String
    let schema: String
    let likerSchema: String
    let likerIDReferenceKey: FieldKey
    let targetSchema: String
    let targetIDReferenceKey: FieldKey
    
    public init<Target: Likeable>(
        for target: Target.Type = Target.self,
        likerSchema: String = Target.LikedBy.schema,
        likerIDReferenceKey: FieldKey = .id,
        targetSchema: String = Target.schema,
        targetIDReferenceKey: FieldKey = .id
    ) {
        self.name = "_\(Target.self)_LikeMigration"
        self.schema = Like<Target>.schema
        self.likerSchema = likerSchema
        self.likerIDReferenceKey = likerIDReferenceKey
        self.targetSchema = targetSchema
        self.targetIDReferenceKey = targetIDReferenceKey
    }
    
    public func prepare(on database: Database) async throws {
        try await database
            .schema(schema)
            .id()
            .field("liker_id", .uuid, .required, .references(likerSchema, likerIDReferenceKey, onDelete: .cascade))
            .field("target_id", .uuid, .required, .references(targetSchema, targetIDReferenceKey, onDelete: .cascade))
            .field("liked_at", .datetime, .required)
            .unique(on: "liker_id", "target_id")
            .create()
    }
    
    public func revert(on database: Database) async throws {
        try await database.schema(schema).delete()
    }
}
