//
//  Icon.swift
//
//  Created by Zac White.
//  Copyright © 2020 Velos Mobile LLC / https://velosmobile.com / All rights reserved.
//

import SwiftUI

struct Icon : View {

    var body: some View {
        /// Note: All of these assume a canvas size of 1024.
        let spacing: CGFloat = 80
        let radius: CGFloat = 150
        let pillLength: CGFloat = 600
        let pillRotation: Angle = .degrees(31)

        let background = LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
        let primaryColor = Color.white

        return IconStack { canvas in
            background
                .edgesIgnoringSafeArea(.all)

            HStack(alignment: .center, spacing: canvas[spacing]) {
                HStack(alignment: .top, spacing: canvas[spacing]) {
                    RoundedRectangle(cornerRadius: canvas[radius])
                        .fill(primaryColor)
                        .frame(width: canvas[radius], height: canvas[pillLength])
                        .rotationEffect(pillRotation)
                    RoundedRectangle(cornerRadius: canvas[radius])
                        .fill(primaryColor)
                        .frame(width: canvas[radius], height: canvas[pillLength])
                        .rotationEffect(pillRotation)
                    RoundedRectangle(cornerRadius: canvas[radius])
                        .fill(primaryColor)
                        .frame(width: canvas[radius], height: canvas[pillLength])
                        .rotationEffect(pillRotation)
                }
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
