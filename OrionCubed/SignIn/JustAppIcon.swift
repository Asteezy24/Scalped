//
//  JustAppIcon.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 1/30/21.
//

import SwiftUI

struct JustAppIcon: View {
    let frame: CGFloat

    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom, spacing: 0) {
                ZStack {
                    BadgeSymbol(symbolColor: .purple)
                        .frame(width: frame, height: frame)
                    .offset(x: geometry.size.width * 0.05, y: 0)
                    BadgeSymbol(symbolColor: .white)
                        .frame(width: frame, height: frame)
                        .offset(x: geometry.size.width / 2 * -0.05, y: 0)
                }
            }
        }
    }
}

struct JustAppIcon_Previews: PreviewProvider {
    static var previews: some View {
        JustAppIcon(frame: 100)
    }
}

