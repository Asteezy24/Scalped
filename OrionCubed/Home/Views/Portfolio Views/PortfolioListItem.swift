//
//  PortfolioListItem.swift
//  Scalped
//
//  Created by Alexander Stevens on 1/30/21.
//

import SwiftUI

struct PortfolioListItem: View {
    
    let item: PortfolioItem
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    Text(item.underlying).font(.headline)
                        .padding()
                    Spacer()
                }
            }
        }
        .background(Color.gray)
        .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)

    }
}

struct PortfolioListItem_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioListItem(item: PortfolioItem(underlying: "", currentPrice: "", currentPL: "", dateBought: "", purchasePrice: "", type: ""))
    }
}
