import DeveloperDefaults
import SwiftUI

struct SettingsRecordView: View {
    let node: SettingsNode

    var body: some View {
        NavigationLink.init {
            RecordListView(node: node)
        } label: {
            TitleRow(title: node.label.title)
        }
    }
}
