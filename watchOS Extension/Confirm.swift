import SwiftUI

struct Confirm: View {
    let finish: Finish
    let done: () -> Void
    
    var body: some View {
        List {
            Section {
                HStack {
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.accentColor)
                    Spacer()
                }
            }
            .listRowBackground(Color.clear)
            
            Section("Streak") {
                Text(finish.streak, format: .number)
                    .font(.body.monospacedDigit())
                    .padding(.trailing)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
            }
            
            Section("Duration") {
                Text((finish.started ..< .now).formatted(.timeDuration))
                    .font(.body.monospacedDigit())
                    .padding(.trailing)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
            }
            
            Section("Steps") {
                Text(finish.steps, format: .number)
                    .font(.body.monospacedDigit())
                    .padding(.trailing)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
            }
            
            Section("Distance") {
                Text(.init(value: .init(finish.meters),
                           unit: UnitLength.meters),
                     format: .measurement(width: .abbreviated,
                                          usage: .general,
                                          numberFormatStyle: .number))
                    .font(.body.monospacedDigit())
                    .padding(.trailing)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
            }
            
            Section("Squares") {
                Text(finish.squares, format: .number)
                    .font(.body.monospacedDigit())
                    .padding(.trailing)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
            }
            
            Section {
                HStack {
                    Spacer()
                    Button(action: done) {
                        ZStack {
                            Capsule()
                                .fill(Color.white)
                            Text("Done")
                                .font(.callout.weight(.medium))
                                .padding(.horizontal, 30)
                                .padding()
                        }
                        .fixedSize()
                    }
                    .buttonStyle(.plain)
                    .foregroundColor(.black)
                    Spacer()
                }
            }
            .listRowBackground(Color.clear)
        }
    }
}
