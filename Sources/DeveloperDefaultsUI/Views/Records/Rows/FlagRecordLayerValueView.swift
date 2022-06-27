import DeveloperDefaults
import SwiftUI

struct FlagRecordLayerValueView: View {
    let title: String
    let raw: String?
    let validated: String?

    init<N: Node>(title: String, _ node: N, _ keyPath: KeyPath<N, String>) {
        self.title = title
        let value = node[keyPath: keyPath]
        self.raw = value
        self.validated = value
    }

    init<N: Node>(title: String, _ node: N, _ keyPath: KeyPath<N, (raw: String?, validated: String?)>) {
        self.title = title
        let value = node[keyPath: keyPath]
        self.raw = value.raw
        self.validated = value.validated
    }

    var body: some View {
        if let raw = self.raw {
            TitleHintValueRow(
                title: self.title,
                value: self.validated ?? "<null>",
                hint: raw
            )
        }
    }
}
