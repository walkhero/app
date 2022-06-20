import SwiftUI

struct About: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 28, weight: .light))
                        .symbolRenderingMode(.hierarchical)
                        .frame(width: 36, height: 36)
                        .foregroundColor(.secondary)
                        .padding(.trailing, 12)
                        .contentShape(Rectangle())
                }
            }
            .padding(.top, 12)
            Image("Logo")
                .foregroundColor(.accentColor)
                .padding(.top, 50)
            Text("Walk Hero")
                .font(.title.weight(.regular))
                .foregroundColor(.primary)
                .padding(.top, 10)
                .padding(.bottom, 100)
            Divider()
            VStack {
                Spacer()
                Button {
                    UIApplication.shared.share(URL(string: "https://apps.apple.com/us/app/walkhero/id1560309078?platform=iphone")!)
                } label: {
                    Image(systemName: "square.and.arrow.up.circle.fill")
                        .symbolRenderingMode(.hierarchical)
                        .font(.system(size: 40, weight: .light))
                        .contentShape(Rectangle())
                }
                
                Spacer()
                Text(verbatim: Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "")
                    .font(.body.monospacedDigit())
                    .foregroundStyle(.secondary)
                HStack(spacing: 0) {
                    Text("From Berlin with ")
                        .foregroundStyle(.tertiary)
                        .font(.caption)
                    Image(systemName: "heart.fill")
                        .font(.footnote)
                        .foregroundStyle(.pink)
                }
                .padding(.bottom)
            }
            .frame(maxWidth: .greatestFiniteMagnitude)
            .background(Color(.secondarySystemBackground))
        }
    }
}
