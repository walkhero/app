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
                
                if Cloud.shared.archive.value.enrolled(.streak) {
                    Item(symbol: "calendar", selected: challenge == .streak) {
                        withAnimation(.spring(blendDuration: 0.5)) {
                            challenge = .streak
                        }
                    }
                }
                
                if Cloud.shared.archive.value.enrolled(.steps) {
                    Item(symbol: "speedometer", selected: challenge == .steps) {
                        withAnimation(.spring(blendDuration: 0.5)) {
                            challenge = .steps
                        }
                    }
                }
                
                if Cloud.shared.archive.value.enrolled(.distance) {
                    Item(symbol: "point.topleft.down.curvedto.point.bottomright.up", selected: challenge == .distance) {
                        withAnimation(.spring(blendDuration: 0.5)) {
                            challenge = .distance
                        }
                    }
                }
                
                if Cloud.shared.archive.value.enrolled(.map) {
                    Item(symbol: "map.fill", selected: challenge == .map) {
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
