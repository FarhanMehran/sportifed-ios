//
//  LineShape.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 11/06/2024.
//

import SwiftUI


public enum Linetype: Sendable {
    case horizontal
    case vertical
}

struct LineShape: Shape {
    var type: Linetype = .horizontal
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        switch type {
        case .horizontal:
            path.move(to: CGPoint(x: 0, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.width, y: rect.midY))
        case .vertical:
            path.move(to: CGPoint(x: rect.midX, y: 0))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.height))
        }
        
        return path
    }
}

public struct Line: View {
    var type: Linetype = .horizontal
    
    public init(type: Linetype) {
        self.type = type
    }
    
    public var body: some View {
        switch type {
        case .horizontal:
            LineShape().stroke(Color.appGreen, style: StrokeStyle(lineWidth: 1, dash: [2])).frame(height: 1)
        case .vertical:
            LineShape(type: .vertical).stroke(Color.appGreen, style: StrokeStyle(lineWidth: 1, dash: [2])).frame(width: 1)
        }
    }
}

extension View {
    func dashedBorder() -> some View {
        overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [8]))
                .foregroundColor(.appGreen)
        )
    }
}
#Preview {
    DetailView(viewModel: DetailViewModel())
}
