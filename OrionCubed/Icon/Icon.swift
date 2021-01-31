//
//  Icon.swift
//
//  Created by Zac White.
//  Copyright © 2020 Velos Mobile LLC / https://velosmobile.com / All rights reserved.
//

import SwiftUI

struct BadgeSymbol: View {
    let symbolColor: Color
    static let gradientStart = Color.purple
    static let gradientEnd = Color.blue
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = min(geometry.size.width, geometry.size.height)
                let height = width * 0.75
                let spacing = width * 0.030
                let middle = width / 2
                let topWidth = 0.226 * width
                let topHeight = 0.488 * height
                
                path.addLines([
                    CGPoint(x: middle, y: spacing),
                    CGPoint(x: middle - topWidth, y: topHeight - spacing),
                    CGPoint(x: middle, y: topHeight / 2 + spacing),
                    CGPoint(x: middle + topWidth, y: topHeight - spacing),
                    CGPoint(x: middle, y: spacing)
                ])
                
                path.move(to: CGPoint(x: middle, y: topHeight / 2 + spacing * 3))
                path.addLines([
                    CGPoint(x: middle - topWidth, y: topHeight + spacing),
                    CGPoint(x: spacing, y: height - spacing),
                    CGPoint(x: width - spacing, y: height - spacing),
                    CGPoint(x: middle + topWidth, y: topHeight + spacing),
                    CGPoint(x: middle, y: topHeight / 2 + spacing * 3)
                ])
            }
            .fill(LinearGradient(
                gradient: .init(colors: [symbolColor, Self.gradientEnd]),
                startPoint: .init(x: 0.5, y: 0),
                endPoint: .init(x: 0.5, y: 0.6)
            ))
        }
    }
}

struct Icon : View {
    
    var body: some View {
        /// Note: All of these assume a canvas size of 1024.
        let radius: CGFloat = 550
        let pillLength: CGFloat = 600
        let background = Color.black//LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
        
        return IconStack { canvas in
            background
                .edgesIgnoringSafeArea(.all)
            
            HStack(alignment: .bottom, spacing: 0) {
                ZStack {
                    BadgeSymbol(symbolColor: .purple)
                        .frame(width: canvas[radius], height: canvas[pillLength])
                    .offset(x: canvas[75], y: 0)
                    BadgeSymbol(symbolColor: .white)
                        .frame(width: canvas[radius], height: canvas[pillLength])
                    .offset(x: canvas[-75], y: 0)
                }.offset(y: canvas[50])
            }
        }
    }
}

#if DEBUG
struct Icon_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            Icon()
                .previewIcon()
                .previewLayout(.sizeThatFits)
            Icon()
                .previewHomescreen()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.purple, .orange]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
                .previewLayout(.fixed(width: 500, height: 500))
        }
    }
}
#endif
