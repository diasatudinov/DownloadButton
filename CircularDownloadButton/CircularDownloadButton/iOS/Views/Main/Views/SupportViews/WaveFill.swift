//
//  WafeFill.swift
//  CircularDownloadButton
//
//  Created by Atudinov Dias on 19.08.2023.
//

import SwiftUI

struct WaveFill: Shape {
    //MARK: - Variables
    var curve: CGFloat
    
    let curveHeight: CGFloat
    let curveLength: CGFloat
    
    //MARK: - Functions
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.width, y: rect.height * 2))
        path.addLine(to: CGPoint(x: 0, y: rect.height * 2))
        
        for i in stride(from: 0, to: CGFloat(rect.width), by: 1) {
            path.addLine(to: CGPoint(x: i, y: sin(((i / rect.height) + curve) * curveLength * .pi) * curveHeight + rect.midY))
        }
        return path
    }
    
    
}

struct WafeFill_Previews: PreviewProvider {
    static var previews: some View {
        WaveFill(curve: 1, curveHeight: 4, curveLength: 3)
            .fill(Color.orange.opacity(0.5))
            .opacity(0.5)
            .frame(width: 200, height: 100)
            .offset(y: 140)
    }
}
