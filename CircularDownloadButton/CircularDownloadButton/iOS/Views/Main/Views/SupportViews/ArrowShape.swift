//
//  ArrowShape.swift
//  CircularDownloadButton
//
//  Created by Atudinov Dias on 19.08.2023.
//

import SwiftUI

struct ArrowShape: Shape {
    //MARK: - Variables
    let lineWidth: CGFloat
    
    var animatableX: CGFloat = 0
    var lineDifference: CGFloat = 0
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get {
            AnimatablePair(animatableX, lineDifference)
        }
        
        set {
            self.animatableX = newValue.first
            self.lineDifference = newValue.second
        }
    }
    //MARK: - Functions
    func path(in rect: CGRect) -> Path {
        let cX: CGFloat = rect.midX
        let cY: CGFloat = rect.midY
        
        var path = Path()
        path.move(to: CGPoint(x: cX, y: cY - lineWidth / 2 + lineDifference))
        path.addLine(to: CGPoint(x: cX, y: cY + lineWidth / 2))
        path.addLine(to: CGPoint(x: cX - lineWidth / 3 + animatableX, y: cY - 45 + lineWidth / 2 + animatableX))
        path.move(to: CGPoint(x: cX, y: cY + lineWidth / 2))
        path.addLine(to: CGPoint(x: cX + lineWidth / 3 - animatableX, y: cY - 45 + lineWidth / 2 + animatableX))

        return path
    }
}

struct ArrowShape_Previews: PreviewProvider {
    static var previews: some View {
        ArrowShape(lineWidth: 100)
            .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
    }
}
