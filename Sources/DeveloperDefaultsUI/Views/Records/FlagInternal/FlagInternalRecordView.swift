import DeveloperDefaults
import SwiftUI

struct FlagInternalRecordView: View {
    let node: FlagInternalNode

    @EnvironmentObject var selectionManager: RecordSelectionManager

    var body: some View {
        Button {
            selectionManager.node = self.node
        } label: {
            TitleValueRow(title: node.label.title, value: node.cachedValue)
        }
    }
}
