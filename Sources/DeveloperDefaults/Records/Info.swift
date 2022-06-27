public protocol InfoProvider {
    static func info() -> String
}

@propertyWrapper
public struct Info<I> where I: InfoProvider {
    let node: InfoNode

    public var wrappedValue: () -> Void {
        fatalError("Direct usage of Info is restricted")
    }

    public init(group: Int = #line) {
        self.node = InfoNode(
            info: { I.info() },
            group: group
        )
    }
}

extension Info: Record {
    var recordNode: Node { self.node }
}
