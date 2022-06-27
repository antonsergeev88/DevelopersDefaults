import SwiftUI

struct CloseToolbarButton: View {
    static var closeHandler: () -> Void = {}

    var body: some View {
        Button("Close") {
            Self.closeHandler()
        }
    }
}
