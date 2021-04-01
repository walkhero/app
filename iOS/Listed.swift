import SwiftUI
import Hero

struct Listed: View {
    @Binding var session: Session
    let list: [Walk.Listed]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    withAnimation(.spring(blendDuration: 0.3)) {
                        session.section = .home
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .frame(width: 30, height: 50)
                        .padding(.leading)
                }
                Text("Walks")
                    .font(Font.footnote.bold())
                Spacer()
            }
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.secondarySystemBackground))
                if list.isEmpty {
                    VStack {
                        Image("world")
                        Text("Ready to start\nyour first walk")
                            .font(.callout)
                            .multilineTextAlignment(.center)
                            .padding(.top)
                    }
                } else {
                    ScrollView {
                        VStack(spacing: 0) {
                            Spacer()
                                .frame(height: 5)
                            ForEach(list, id: \.self) {
                                Item(session: $session, item: $0)
                                Rectangle()
                                    .fill(Color(.tertiarySystemBackground))
                                    .frame(height: 1)
                                    .padding(.horizontal)
                            }
                            Spacer()
                                .frame(height: 5)
                        }
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}