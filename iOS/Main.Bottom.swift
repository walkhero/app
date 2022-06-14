import SwiftUI

extension Main {
    struct Bottom: View {
//        @ObservedObject var session
        
        var body: some View {
            VStack(spacing: 0) {
                Divider()
                HStack(spacing: 0) {
                    Button {
                        
                    } label: {
                        Image(systemName: "gear")
                            .font(.system(size: 22, weight: .light))
                            .symbolRenderingMode(.hierarchical)
                            .frame(height: 60)
                            .frame(maxWidth: .greatestFiniteMagnitude)
                            .contentShape(Rectangle())
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "star")
                            .font(.system(size: 22, weight: .light))
                            .symbolRenderingMode(.hierarchical)
                            .frame(height: 60)
                            .frame(maxWidth: .greatestFiniteMagnitude)
                            .contentShape(Rectangle())
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "figure.walk.circle.fill")
                            .font(.system(size: 40, weight: .bold))
                            .symbolRenderingMode(.hierarchical)
                            .frame(height: 60)
                            .frame(maxWidth: .greatestFiniteMagnitude)
                            .contentShape(Rectangle())
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "calendar")
                            .font(.system(size: 22, weight: .light))
                            .symbolRenderingMode(.hierarchical)
                            .frame(height: 60)
                            .frame(maxWidth: .greatestFiniteMagnitude)
                            .contentShape(Rectangle())
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "chart.pie")
                            .font(.system(size: 22, weight: .light))
                            .symbolRenderingMode(.hierarchical)
                            .frame(height: 60)
                            .frame(maxWidth: .greatestFiniteMagnitude)
                            .contentShape(Rectangle())
                    }
                }
                .padding(.vertical, 10)
            }
        }
    }
}
