import SwiftUI
import Hero

extension Walking {
    struct Segmented: View {
        @Binding var session: Session
        @Binding var challenge: Challenge?
        
        var body: some View {
            HStack(spacing: 5) {
                Item(symbol: "clock", status: challenge == nil ? .selected : .on) {
                    withAnimation(.spring(blendDuration: 0.5)) {
                        challenge = nil
                    }
                }
                Item(symbol: "calendar", status: challenge == .streak ? .selected : session.archive.enrolled(.streak) ? .on : .off) {
                    guard session.archive.enrolled(.streak) else { return }
                    withAnimation(.spring(blendDuration: 0.5)) {
                        challenge = .streak
                    }
                }
                Item(symbol: "speedometer", status: challenge == .steps ? .selected : session.archive.enrolled(.steps) ? .on : .off) {
                    guard session.archive.enrolled(.steps) else { return }
                    withAnimation(.spring(blendDuration: 0.5)) {
                        challenge = .steps
                    }
                }
                Item(symbol: "point.topleft.down.curvedto.point.bottomright.up", status: challenge == .distance ? .selected : session.archive.enrolled(.distance) ? .on : .off) {
                    guard session.archive.enrolled(.distance) else { return }
                    withAnimation(.spring(blendDuration: 0.5)) {
                        challenge = .distance
                    }
                }
                Item(symbol: "map.fill", status: challenge == .map ? .selected : session.archive.enrolled(.map) ? .on : .off) {
                    guard session.archive.enrolled(.map) else { return }
                    withAnimation(.spring(blendDuration: 0.5)) {
                        challenge = .map
                    }
                }
            }
            .padding(.top)
        }
    }
}
