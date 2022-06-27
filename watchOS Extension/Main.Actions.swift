import SwiftUI

extension Main {
    struct Actions: View {
        @ObservedObject var session: Session
        
        var body: some View {
            VStack {
                Spacer()
                
                Button {
                    Task {
                        await cloud.start()
                    }
                } label: {
                    Image(systemName: "figure.walk")
                        .font(.system(size: 24, weight: .medium))
                        .contentShape(Rectangle())
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal, 16)
                .padding(.bottom)
                
                if let updated = session.chart.updated {
                    Text("Walked " + updated.end
                        .formatted(.relative(presentation: .named,
                                             unitsStyle: .abbreviated)))
                    .font(.footnote.weight(.regular))
                    .foregroundStyle(.secondary)
                }
                
                if let updated = session.chart.updated?.start, Calendar.global.isDateInToday(updated) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 22, weight: .light))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(.accentColor)
                        Text("Walk today")
                            .font(.footnote.weight(.medium))
                            .foregroundColor(.accentColor)
                    }
                } else {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 22, weight: .light))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(.pink)
                        Text("No walk today")
                            .font(.footnote.weight(.medium))
                            .foregroundStyle(.pink)
                    }
                }
            }
        }
    }
}
