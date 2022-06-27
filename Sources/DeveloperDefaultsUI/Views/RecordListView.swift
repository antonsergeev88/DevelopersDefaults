import DeveloperDefaults
import SwiftUI

struct RecordListView: View {
    let node: Node

    var body: some View {
        List(node.children.grouped(by: \.group).indexed()) { group in
            Section {
                ForEach(group.element.indexed()) { element in
                    RecordView(node: element.element)
                }
            }
        }
        .toolbar {
            HStack {
                RecordListMenuView(node: node)
                CloseToolbarButton()
            }
        }
        .navigationTitle(node.label.title)
    }
}
