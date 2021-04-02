import SwiftUI
import Hero

extension Home {
    struct Item: View {
        @Binding var session: Session
        let challenge: Challenge
        
        var body: some View {
            Button {
                withAnimation(.spring(blendDuration: 0.4)) {
                    session.section = .challenge(challenge)
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(challenge.background)
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(challenge.title)
                                    .font(.callout)
                                    .fontWeight(.heavy)
                                    .fixedSize(horizontal: false, vertical: true)
                                Text(challenge.subtitle)
                                    .font(.caption)
                            }
                            Spacer()
                            Image(systemName: challenge.symbol)
                                .font(.title)
                        }
                    }
                    .padding()
                    .foregroundColor(.white)
                }
                .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal)
        }
    }
}
