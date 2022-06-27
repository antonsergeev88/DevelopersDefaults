import DeveloperDefaults
import SwiftUI

struct FlagEditingRow: View {
    let allValues: [String]
    let updateValue: (String) -> Void

    @Binding var currentValue: String

    @EnvironmentObject var selectionManager: RecordSelectionManager

    init(_ node: FlagNode, currentValue: Binding<String>) {
        self.allValues = node.allValues
        self._currentValue = currentValue
        self.updateValue = { value in
            node.updateDebugValue(value.isEmpty ? nil : value)
        }
    }

    init(_ node: FlagVolatileNode, currentValue: Binding<String>) {
        self.allValues = node.allValues
        self._currentValue = currentValue
        self.updateValue = { value in
            node.updateDebugValue(value.isEmpty ? nil : value)
        }
    }

    init(_ node: FlagInternalNode, currentValue: Binding<String>) {
        self.allValues = node.allValues
        self._currentValue = currentValue
        self.updateValue = { value in
            node.updateDebugValue(value.isEmpty ? nil : value)
        }
    }

    var body: some View {
        if self.allValues.isEmpty {
            TextField("Edit debug value", text: self.$currentValue)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .onChange(of: currentValue) { newValue in
                    selectionManager.objectWillChange.send()
                    self.updateValue(newValue)
                }
        } else {
            Menu("Choose debug value") {
                SwiftUI.Section {
                    ForEach(self.allValues.indexed()) { value in
                        Button(value.element) {
                            currentValue = value.element
                            selectionManager.objectWillChange.send()
                            self.updateValue(value.element)
                        }
                    }
                }
                SwiftUI.Section {
                    Button("Remove") {
                        currentValue = ""
                        selectionManager.objectWillChange.send()
                        self.updateValue("")
                    }
                }
            }
        }
    }
}
