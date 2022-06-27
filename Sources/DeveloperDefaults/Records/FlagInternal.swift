extension Flag {
    @propertyWrapper
    public struct Internal {
        private let node: FlagInternalNode

        public var wrappedValue: V {
            V(self.node.cachedValue)!
        }

        public init(wrappedValue defaultValue: V, group: Int = #line) {
            self.node = FlagInternalNode(
                type: "\(V.self)",
                defaultValue: defaultValue.description,
                allValue: [],
                validator: { V($0)?.description },
                group: group
            )
        }

        public init(wrappedValue defaultValue: V, group: Int = #line) where V: CaseIterable {
            self.node = FlagInternalNode(
                type: "\(V.self)",
                defaultValue: defaultValue.description,
                allValue: V.allCases.map(\.description),
                validator: {
                    if let validatedValue = V($0)?.description,
                       V.allCases.map(\.description).contains(validatedValue)
                    {
                        return validatedValue
                    } else {
                        return nil
                    }
                },
                group: group
            )
        }

        public init(wrappedValue defaultValue: Bool, group: Int = #line) where V == Bool {
            self.node = FlagInternalNode(
                type: "\(V.self)",
                defaultValue: defaultValue.description,
                allValue: [true, false].map(\.description),
                validator: {
                    switch $0.lowercased() {
                    case "true", "1", "+", "yes", "y": return true.description
                    case "false", "0", "-", "no", "n": return false.description
                    default: return nil
                    }
                },
                group: group
            )
        }
    }
}

extension Flag.Internal: Record {
    var recordNode: Node { self.node }
}
