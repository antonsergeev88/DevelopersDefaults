import SwiftUI

struct TitleValueRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
            Spacer()
            Text(value)
        }
        .foregroundColor(.primary)
    }
}
