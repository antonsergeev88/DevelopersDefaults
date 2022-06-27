import Foundation

class DefaultsStorage {
    let environmentLayer: StorageLayer
    let debugLayer: StorageLayer
    let mainLayer: StorageLayer
    let userLayer: StorageLayer
    let defaultLayer: StorageLayer
    let cacheLayer: StorageLayer
    let typesLayer: StorageLayer

    init(userDefaults: UserDefaults) {
        self.environmentLayer = StorageLayer(
            userDefaults: userDefaults,
            key: "DevelopmentDefaultsEnvironmentLayerKey",
            isPersistent: false
        )
        self.debugLayer = StorageLayer(
            userDefaults: userDefaults,
            key: "DevelopmentDefaultsDebugLayerKey",
            isPersistent: true
        )
        self.mainLayer = StorageLayer(
            userDefaults: userDefaults,
            key: "DevelopmentDefaultsMainLayerKey",
            isPersistent: true
        )
        self.userLayer = StorageLayer(
            userDefaults: userDefaults,
            key: "DevelopmentDefaultsUserLayerKey",
            isPersistent: true
        )
        self.defaultLayer = StorageLayer(
            userDefaults: userDefaults,
            key: "DevelopmentDefaultsDefaultLayerKey",
            isPersistent: false
        )
        self.cacheLayer = StorageLayer(
            userDefaults: userDefaults,
            key: "DevelopmentDefaultsCacheLayerKey",
            isPersistent: false
        )
        self.typesLayer = StorageLayer(
            userDefaults: userDefaults,
            key: "DevelopmentDefaultsTypesLayerKey",
            isPersistent: false
        )
    }
}

struct StorageLayer {
    private let userDefaults: UserDefaults
    private let key: String
    private let isPersistent: Bool

    init(userDefaults: UserDefaults, key: String, isPersistent: Bool) {
        self.userDefaults = userDefaults
        self.key = key
        self.isPersistent = isPersistent

        if !isPersistent {
            userDefaults.setValue(nil, forKey: key)
        }
    }

    subscript(_ key: String) -> String? {
        get {
            let values = self.userDefaults.value(forKey: self.key) as? [String: String] ?? [:]
            return values[key]
        }
        nonmutating set {
            var values = self.userDefaults.value(forKey: self.key) as? [String: String] ?? [:]
            values[key] = newValue
            if self.isPersistent {
                self.userDefaults.setValue(values, forKey: self.key)
            } else {
                self.userDefaults.register(defaults: [self.key: values])
            }
        }
    }

    func replace(with values: [String: String]) {
        if self.isPersistent {
            self.userDefaults.setValue(values, forKey: self.key)
        } else {
            self.userDefaults.register(defaults: [self.key: values])
        }
    }
}
