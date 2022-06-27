import DeveloperDefaults
import SwiftUI

struct SelectedRecordView: View {
    @EnvironmentObject var selectionManager: RecordSelectionManager

    var body: some View {
        switch selectionManager.node {
        case let info as InfoNode: SelectedInfoRecordView(node: info)
        case let flag as FlagNode: SelectedFlagRecordView(node: flag)
        case let flagVolatile as FlagVolatileNode: SelectedFlagVolatileRecordView(node: flagVolatile)
        case let flagInternal as FlagInternalNode: SelectedFlagInternalRecordView(node: flagInternal)
        default: EmptyView()
        }
    }
}
