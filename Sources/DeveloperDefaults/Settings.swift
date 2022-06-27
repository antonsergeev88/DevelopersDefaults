import DeveloperDefaultsRuntime
import Foundation

open class Settings {
    public static let rootNode: RootNode = {
        if let settingsClasses = findAllDirectSubclassesOfClass(Settings.self) as? [Settings.Type] {
            for settingsClass in settingsClasses {
                _ = settingsClass.init()
            }
        } else {
            assertionFailure()
        }
        let settingsNodes = registeredNodes
            .filter { $0.value.parent == nil }
            .sorted { $0.key < $1.key }
            .map(\.value)
        let rootNode = RootNode()
        for settingsNode in settingsNodes {
            rootNode.addChild(settingsNode)
        }
        rootNode.label = .init("allSettings")
        return rootNode
    }()

    public static var userDefaults: UserDefaults = .standard
    static let storage = DefaultsStorage(userDefaults: Settings.userDefaults)

    private static var registeredNodes: [String: SettingsNode] = [:]
    private static let lock = NSRecursiveLock()

    let node: SettingsNode

    public static func updateMainLayer(with values: [String: String]) {
        Settings.storage.mainLayer.replace(with: values)
    }

    private static func fill(_ settings: Settings) {
        let reflection = Mirror(reflecting: settings)
        var currentGroup = 0
        var currentGroupSize = 1
        for (rawLabel, value) in reflection.children {
            guard let rawLabel = rawLabel,
                  rawLabel.first == "_",
                  let record = value as? Record
            else { continue }
            let label = Node.Label(String(rawLabel.dropFirst()))
            let node = record.recordNode
            node.label = label
            if currentGroup + currentGroupSize == node.group {
                node.group = currentGroup
                currentGroupSize += 1
            } else {
                currentGroup = node.group
                currentGroupSize = 1
            }
            settings.node.addChild(node)
        }
    }

    required public init() {
        Settings.lock.lock()
        defer { Settings.lock.unlock() }
        let settingsKey = NSStringFromClass(Self.self)
        if let settingsNode = Settings.registeredNodes[settingsKey] {
            self.node = settingsNode
        } else {
            self.node = SettingsNode()
            Settings.registeredNodes[settingsKey] = self.node
            self.node.label = .init("\(Self.self)")
            Settings.fill(self)
        }
    }
}
