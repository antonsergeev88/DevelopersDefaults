import DeveloperDefaults
import SwiftUI

struct FlagRecordView: View {
    let node: FlagNode

    @EnvironmentObject var selectionManager: RecordSelectionManager

    var body: some View {
        Button {
            selectionManager.node = self.node
        } label: {
            TitleValueRow(title: node.label.title, value: node.cachedValue)
        }
    }
}
