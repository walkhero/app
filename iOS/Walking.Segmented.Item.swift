import SwiftUI

extension Walking.Segmented {
    struct Item: View {
        let symbol: String
        let selected: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(selected ? Color.accentColor : .clear)
                    Image(systemName: symbol)
                        .font(.title2)
                        .foregroundColor(selected ? .white : .secondary)
                }
                .frame(width: 46, height: 46)
            }
        }
    }
}
