import DeveloperDefaults
import SwiftUI

struct RecordView: View {
    let node: Node

    var body: some View {
        switch self.node {
        case let settings as SettingsNode: SettingsRecordView(node: settings)
        case let info as InfoNode: InfoRecordView(node: info)
        case let action as ActionNode: ActionRecordView(node: action)
        case let flag as FlagNode: FlagRecordView(node: flag)
        case let flagVolatile as FlagVolatileNode: FlagVolatileRecordView(node: flagVolatile)
        case let flagInternal as FlagInternalNode: FlagInternalRecordView(node: flagInternal)
        default: EmptyView()
        }
    }
}
