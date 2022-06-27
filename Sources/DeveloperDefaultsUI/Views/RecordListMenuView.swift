import DeveloperDefaults
import SwiftUI

struct RecordListMenuView: View {
    let node: Node

    @EnvironmentObject var selectionManager: RecordSelectionManager

    var body: some View {
        Menu("More") {
            SwiftUI.Section.init {
                Button("Clear Debug Values") {
                    selectionManager.objectWillChange.send()
                    clearDebugs()
                }
                Button("Write Defaults to Debug") {
                    selectionManager.objectWillChange.send()
                    writeDefaults()
                }
            }
        }
    }

    private func clearDebugs() {
        func clear(node: Node) {
            switch node {
            case let flag as FlagNode:
                flag.updateDebugValue(nil)
            case let flag as FlagVolatileNode:
                flag.updateDebugValue(nil)
            case let flag as FlagInternalNode:
                flag.updateDebugValue(nil)
            default:
                break
            }
            for node in node.children {
                clear(node: node)
            }
        }
        clear(node: self.node)
    }

    private func writeDefaults() {
        func writeDefaults(to node: Node) {
            switch node {
            case let flag as FlagNode:
                flag.updateDebugValue(flag.defaultValue)
            case let flag as FlagVolatileNode:
                flag.updateDebugValue(flag.defaultValue)
            case let flag as FlagInternalNode:
                flag.updateDebugValue(flag.defaultValue)
            default:
                break
            }
            for node in node.children {
                writeDefaults(to: node)
            }
        }
        writeDefaults(to: self.node)
    }
}
