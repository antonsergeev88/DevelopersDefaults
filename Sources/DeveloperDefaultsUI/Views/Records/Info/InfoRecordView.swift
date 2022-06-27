import DeveloperDefaults
import SwiftUI
import UIKit

struct InfoRecordView: View {
    let node: InfoNode

    @EnvironmentObject var selectionManager: RecordSelectionManager

    var body: some View {
        Button {
            UIPasteboard.general.string = node.info()
            withAnimation(.easeOut) {
                selectionManager.node = self.node
            }
        } label: {
            TitleHintValueRow(title: node.label.title, value: node.info(), hint: "")
        }
    }
}
