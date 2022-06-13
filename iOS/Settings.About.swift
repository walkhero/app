import SwiftUI
import Hero

extension Settings {
    struct About: View {
        var body: some View {
            List {
                Section {
                    HStack {
                        Spacer()
                        VStack {
                            Image("Logo")
                                .foregroundColor(.primary)
                            Text(verbatim: "Walk Hero")
                                .font(.title3.weight(.medium))
                                .foregroundStyle(.primary)
                            Text(verbatim: Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "")
                                .font(.body.monospacedDigit().weight(.light))
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 70)
                        Spacer()
                    }
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                
                Section {
                    Link(destination: URL(string: "https://walkhero.github.io/about")!) {
                        HStack {
                            Text("Walk Hero")
                                .font(.callout)
                            Spacer()
                            Image(systemName: "link")
                                .font(.title3)
                        }
                    }
                    
                    Button {
                        UIApplication.shared.review()
                    } label: {
                        HStack {
                            Text("Rate on the App Store")
                                .font(.callout)
                            Spacer()
                            Image(systemName: "star")
                                .font(.title3)
                        }
                    }
                }
                
                Section {
                    HStack(spacing: 0) {
                        Spacer()
                        Text("From Berlin with ")
                        Image(systemName: "heart")
                        Spacer()
                    }
                }
                .font(.caption)
                .foregroundColor(.secondary)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
            .symbolRenderingMode(.multicolor)
            .listStyle(.insetGrouped)
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
