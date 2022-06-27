import SwiftUI

struct TitleHintValueRow: View {
    let title: String
    let value: String
    let hint: String

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(alignment: .lastTextBaseline) {
                Text(title)
                Spacer()
                Text(hint)
            }
            .font(.caption2)
            Text(value)
        }
        .foregroundColor(.primary)
    }
}
