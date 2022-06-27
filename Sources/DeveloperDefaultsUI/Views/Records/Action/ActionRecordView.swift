import DeveloperDefaults
import SwiftUI

struct ActionRecordView: View {
    let node: ActionNode

    @EnvironmentObject var selectionManager: RecordSelectionManager

    var body: some View {
        Button {
            node.action()
            selectionManager.objectWillChange.send()
        } label: {
            TitleRow(title: node.label.title)
        }
    }
}
