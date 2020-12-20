//
//  TabBarMiddleItem.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/19/20.
//

import SwiftUI

public struct TabBarMiddleItem: View {
    let radius: CGFloat
    let action: () -> Void
    
    public init(radius: CGFloat, action: @escaping () -> Void) {
        self.radius = radius
        self.action = action
    }
    
    public var body: some View {
        VStack(spacing:0) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: radius, height: radius, alignment: .center)
                .foregroundColor(Color(.systemBlue))
                .background(Color(.white))
                .cornerRadius(radius/2)
            
        }
        .frame(width: radius, height: radius)
        .onTapGesture(perform: action)
        
    }
}

struct TabBarMiddleItem_Previews: PreviewProvider {
    static var previews: some View {
        TabBarMiddleItem(radius: 55) { }
    }
}
