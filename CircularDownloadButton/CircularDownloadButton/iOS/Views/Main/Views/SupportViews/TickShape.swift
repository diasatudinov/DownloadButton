//
//  TickShape.swift
//  CircularDownloadButton
//
//  Created by Atudinov Dias on 19.08.2023.
//

import SwiftUI

struct TickShape: Shape {
    //MARK: - Variables
    let scaleFactor: CGFloat
    //MARK: - Functions
    func path(in rect: CGRect) -> Path {
        let cX: CGFloat = rect.midX + 4
        let cY: CGFloat = rect.midY - 3
        
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.move(to: CGPoint(x: cX - (42 * scaleFactor), y: cY - (4 * scaleFactor)))
        
        path.addLine(to: CGPoint(x: cX - (scaleFactor * 18), y: cY + (scaleFactor * 28)))
        path.addLine(to: CGPoint(x: cX + (scaleFactor * 40), y: cY - (scaleFactor * 36)))
        
        return path
    }
    
   
}

struct TickShape_Previews: PreviewProvider {
    static var previews: some View {
        TickShape(scaleFactor: 1)
            .stroke(lineWidth: 4)
    }
}
