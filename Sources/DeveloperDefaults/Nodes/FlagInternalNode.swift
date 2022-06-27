import Foundation

public class FlagInternalNode: Node {
    public let type: String
    public let defaultValue: String
    public let allValues: [String]
    public let validator: (String) -> String?
    public internal(set) var cachedValue: String

    public override var label: Node.Label {
        didSet {
            assert(Settings.storage.typesLayer[self.label.key] == nil || Settings.storage.typesLayer[self.label.key] == self.type)
            assert(Settings.storage.defaultLayer[self.label.key] == nil || Settings.storage.defaultLayer[self.label.key] == self.defaultValue)
            if let cachedValue = Settings.storage.cacheLayer[self.label.key] {
                self.cachedValue = cachedValue
            } else {
                Settings.storage.typesLayer[self.label.key] = self.type
                Settings.storage.defaultLayer[self.label.key] = self.defaultValue
                Settings.storage.environmentLayer[self.label.key] = ProcessInfo.processInfo.environment[self.label.key]

                self.cachedValue = self.environmentValue.validated ?? self.debugValue.validated ?? self.cachedValue
                Settings.storage.cacheLayer[self.label.key] = self.cachedValue
            }
        }
    }

    public var environmentValue: (raw: String?, validated: String?) {
        let raw = Settings.storage.environmentLayer[self.label.key]
        let validated = raw.flatMap(self.validator)
        return (raw, validated)
    }

    public var debugValue: (raw: String?, validated: String?) {
        let raw = Settings.storage.debugLayer[self.label.key]
        let validated = raw.flatMap(self.validator)
        return (raw, validated)
    }

    public func updateDebugValue(_ raw: String?) {
        Settings.storage.debugLayer[self.label.key] = raw
    }

    init(type: String, defaultValue: String, allValue: [String], validator: @escaping (String) -> String?, group: Int) {
        self.type = type
        self.defaultValue = defaultValue
        self.allValues = allValue
        self.validator = validator
        self.cachedValue = defaultValue
        super.init(group: group)
    }
}
