import SwiftUI
import Hero

extension Walking {
    struct Segmented: View {
        @Binding var session: Session
        @Binding var challenge: Challenge?
        
        var body: some View {
            HStack(spacing: 5) {
                Item(symbol: "stopwatch", selected: challenge == nil) {
                    withAnimation(.spring(blendDuration: 0.5)) {
                        challenge = nil
                    }
                }
                
                if session.archive.enrolled(.streak) {
                    Item(symbol: "calendar", selected: challenge == .streak) {
                        guard session.archive.enrolled(.streak) else { return }
                        withAnimation(.spring(blendDuration: 0.5)) {
                            challenge = .streak
                        }
                    }
                }
                
                if session.archive.enrolled(.steps) {
                    Item(symbol: "speedometer", selected: challenge == .steps) {
                        guard session.archive.enrolled(.steps) else { return }
                        withAnimation(.spring(blendDuration: 0.5)) {
                            challenge = .steps
                        }
                    }
                }
                
                if session.archive.enrolled(.distance) {
                    Item(symbol: "point.topleft.down.curvedto.point.bottomright.up", selected: challenge == .distance) {
                        guard session.archive.enrolled(.distance) else { return }
                        withAnimation(.spring(blendDuration: 0.5)) {
                            challenge = .distance
                        }
                    }
                }
                
                if session.archive.enrolled(.map) {
                    Item(symbol: "map.fill", selected: challenge == .map) {
                        guard session.archive.enrolled(.map) else { return }
                        withAnimation(.spring(blendDuration: 0.5)) {
                            challenge = .map
                        }
                    }
                }
            }
            .padding(.top)
        }
    }
}
