import DeveloperDefaults
import SwiftUI

struct SelectedInfoRecordView: View {
    let node: InfoNode
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

    @EnvironmentObject var selectionManager: RecordSelectionManager

    var body: some View {
        ZStack {
            Color.white
                .cornerRadius(20)
            Text("Copied into pasteboard")
                .padding(40)
        }
        .fixedSize()
        .shadow(radius: 20)
        .onReceive(timer) { _ in
            selectionManager.node = nil
        }
    }
}
