import DeveloperDefaults
import SwiftUI

struct FlagVolatileRecordView: View {
    let node: FlagVolatileNode

    @EnvironmentObject var selectionManager: RecordSelectionManager

    var body: some View {
        Button {
            selectionManager.node = self.node
        } label: {
            TitleValueRow(title: node.label.title, value: node.value)
        }
    }
}
