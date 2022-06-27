@propertyWrapper
public struct Section<S> where S: Settings {
    let section: S

    public var wrappedValue: S {
        self.section
    }

    public init(group: Int = #line) {
        self.section = S()
        self.section.node.group = group
    }
}

extension Section: Record {
    var recordNode: Node { self.section.node }
}
