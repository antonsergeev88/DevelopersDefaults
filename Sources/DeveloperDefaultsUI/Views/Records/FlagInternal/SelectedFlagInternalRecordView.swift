import DeveloperDefaults
import SwiftUI

struct SelectedFlagInternalRecordView: View {
    let node: FlagInternalNode

    @State var debugEditingValue = ""

    @EnvironmentObject var selectionManager: RecordSelectionManager

    var body: some View {
        NavigationView {
            List {
                SwiftUI.Section {
                    FlagRecordLayerValueView(title: "Environment", node, \.environmentValue)
                    FlagRecordLayerValueView(title: "Debug", node, \.debugValue)
                    FlagRecordLayerValueView(title: "Default", node, \.defaultValue)
                } header: {
                    Text("Values")
                }
                SwiftUI.Section {
                    FlagEditingRow(node, currentValue: self.$debugEditingValue)
                }
                SwiftUI.Section {
                    TitleHintValueRow(title: "Flag type", value: "Internal", hint: "")
                    TitleHintValueRow(title: "Value type", value: node.type, hint: "")
                    TitleHintValueRow(title: "Key", value: node.label.key, hint: "")
                    TitleHintValueRow(title: "Current value", value: node.cachedValue, hint: "")
                } header: {
                    Text("Meta")
                }
            }
            .toolbar {
                Button("Done") {
                    selectionManager.node = nil
                }
            }
            .navigationTitle(node.label.title)
        }
        .cornerRadius(20)
        .shadow(radius: 20)
        .padding(20)
        .onAppear {
            self.debugEditingValue = node.debugValue.raw ?? ""
        }
    }
}
