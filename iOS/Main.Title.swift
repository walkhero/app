import SwiftUI

extension Main {
    struct Title<C>: View where C : View {
        let title: String
        let content: C
        
        @inlinable init(title: String, @ViewBuilder content: () -> C) {
            self.title = title
            self.content = content()
        }
        
        var body: some View {
            VStack(spacing: 0) {
                HStack {
                    Text(title)
                        .font(.title3.weight(.semibold))
                        .padding(.vertical, 14)
                        .padding(.leading, 20)
                    Spacer()
                    
                    content
                }
                Divider()
            }
            .background(Color(.systemBackground))
        }
    }
}
