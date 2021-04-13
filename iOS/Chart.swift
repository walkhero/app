import SwiftUI

struct Chart: View {
    let values: [Double]
    let color: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
            ZStack {
                Road(values: values)
                    .stroke(color, style: .init(lineWidth: 1, lineCap: .round, lineJoin: .round))
                ForEach(0 ..< values.count, id: \.self) {
                    Dot(y: values[$0], index: $0, radius: $0 == values.count - 1 ? 7 : 3)
                        .fill(color)
                    if $0 == values.count - 1 {
                        Dot(y: values.last!, index: values.count - 1, radius: 7)
                            .stroke(Color(.secondarySystemBackground), lineWidth: 1)
                    }
                }
            }
            .padding(30)
        }
        .frame(height: 220)
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

private struct Pattern: Shape {
    func path(in rect: CGRect) -> Path {
        .init { path in
            path.move(to: .zero)
            (1 ..< Metrics.chart.horizontal).map { rect.maxX / .init(Metrics.chart.horizontal) * .init($0) }.forEach {
                path.move(to: .init(x: $0, y: 0))
                path.addLine(to: .init(x: $0, y: rect.maxY))
            }
            (1 ..< Metrics.chart.vertical).map { rect.maxY / .init(Metrics.chart.vertical) * .init($0) }.forEach {
                path.move(to: .init(x: 0, y: $0))
                path.addLine(to: .init(x: rect.maxX, y: $0))
            }
        }
    }
}

private struct Shade: Shape {
    let values: [Double]
    
    func path(in rect: CGRect) -> Path {
        .init {
            if !values.isEmpty {
                $0.move(to: .init(x: 0, y: rect.maxY))
                $0.addLines(values.enumerated().map {
                    .init(x: .init(rect.maxX / Metrics.chart.max) * .init($0.0), y: .init(rect.maxY) - (.init(rect.maxY) * $0.1))
                })
                $0.addLine(to: .init(x: rect.maxX / Metrics.chart.max * .init(values.count - 1), y: rect.maxY))
                $0.addLine(to: .init(x: 0, y: rect.maxY))
                $0.closeSubpath()
            }
        }
    }
}

private struct Road: Shape {
    let values: [Double]

    func path(in rect: CGRect) -> Path {
        .init {
            $0.move(to: .init(x: 0, y: rect.maxY))
            if !values.isEmpty {
                $0.addLines(values.enumerated().map {
                    .init(x: .init(rect.maxX / Metrics.chart.max) * .init($0.0), y: .init(rect.maxY) - (.init(rect.maxY) * $0.1))
                })
            } else {
                $0.addLine(to: .init(x: rect.maxX, y: rect.maxY))
            }
        }
    }
}

private struct Dot: Shape {
    let y: Double
    let index: Int
    let radius: CGFloat

    func path(in rect: CGRect) -> Path {
        .init {
            $0.addArc(center: .init(x: .init(rect.maxX / Metrics.chart.max) * .init(index), y: .init(rect.maxY) - (.init(rect.maxY) * y)), radius: radius, startAngle: .zero, endAngle: .init(radians: .pi * 2), clockwise: true)
        }
    }
}
