import DeveloperDefaults
import SwiftUI

struct RootSettingsView: View {
    let node = Settings.rootNode

    @StateObject var selectionManager = RecordSelectionManager()

    var body: some View {
        ZStack {
            NavigationView {
                if node.children.count == 1 {
                    RecordListView(node: node.children[0])
                } else {
                    RecordListView(node: node)
                }
            }
            SelectedRecordView()
        }
        .environmentObject(selectionManager)
    }
}
