public protocol Command {
    static func run()
}

@propertyWrapper
public struct Action<C> where C: Command {
    let node: ActionNode

    public var wrappedValue: () -> Void {
        fatalError("Direct usage of Action is restricted")
    }

    public init(group: Int = #line) {
        self.node = ActionNode(
            action: { C.run() },
            group: group
        )
    }
}

extension Action: Record {
    var recordNode: Node { self.node }
}
