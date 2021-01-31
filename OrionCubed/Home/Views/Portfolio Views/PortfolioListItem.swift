//
//  PortfolioListItem.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 1/30/21.
//

import SwiftUI

struct PortfolioListItem: View {
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    Text("NEO/BTC").font(.headline)
                        .padding()
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("Yield").font(.footnote)
                        .padding(.bottom)
                    Spacer()
                }
            }
        }
        .background(Color.blue)
        .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)

    }
}

struct PortfolioListItem_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioListItem()
    }
}
