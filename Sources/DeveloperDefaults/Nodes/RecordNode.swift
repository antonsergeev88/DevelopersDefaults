public class Node {
    public private(set) var parent: Node?
    public private(set) var children = [Node]()
    public internal(set) var group: Int
    public internal(set) var label = Label("")

    convenience init() {
        self.init(group: 0)
    }


    init(group: Int) {
        self.group = group
    }

    func addChild(_ node: Node) {
        self.children.append(node)
        node.parent = self
    }

    func removeFromParent() {
        guard let parent = self.parent else { return }
        parent.children.removeAll { node in
            node === self
        }
    }
}

extension Node {
    public struct Label {
        public let raw: String
        public let key: String
        public let title: String

        init(_ raw: String) {
            self.raw = raw
            self.key = raw.snakeCasedKey()
            self.title = raw.capitalizedTitle()
        }
    }
}
