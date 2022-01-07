import SwiftUI
import Combine

private let size = 32.0
private let radius = 8.0

extension Map {
    struct Header: View {
        @ObservedObject var status: Status
        @State private var stats = false
        @State private var calendar = false
        
        var body: some View {
            VStack(spacing: 0) {
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: radius, style: .continuous)
                            .fill(LinearGradient(
                                gradient: .init(colors: [.accentColor.opacity(0.6), .accentColor]),
                                    startPoint: .top,
                                    endPoint: .bottom))
                            .frame(width: size, height: size)

                        if let image = status.image {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: size - 3, height: size - 3)
                                .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
                        } else {
                            Image(systemName: "person.fill")
                                .font(.body)
                                .foregroundColor(.white)
                        }
                    }
                    .allowsHitTesting(false)
                    
                    Text(verbatim: status.name)
                        .lineLimit(2)
                        .foregroundColor(.primary)
                        .font(.footnote)
                        .allowsHitTesting(false)
                    
                    Spacer()
                    
                    Button {
                        stats = true
                    } label: {
                        Image(systemName: "chart.xyaxis.line")
                            .font(.callout)
                            .allowsHitTesting(false)
                    }
                    .frame(width: 44)
                    .sheet(isPresented: $stats, content: Stats.init)
                    
                    Button {
                        calendar = true
                    } label: {
                        Image(systemName: "calendar")
                            .font(.callout)
                            .allowsHitTesting(false)
                    }
                    .frame(width: 44)
                    .sheet(isPresented: $calendar, content: Ephemeris.init)
                    
                    Button {
                        calendar = true
                    } label: {
                        Image(systemName: "gear")
                            .font(.callout)
                            .allowsHitTesting(false)
                    }
                    .frame(width: 44)
                    .sheet(isPresented: $calendar, content: Ephemeris.init)
                }
                .padding()
            }
            .background(Color(.secondarySystemBackground))
        }
    }
}
