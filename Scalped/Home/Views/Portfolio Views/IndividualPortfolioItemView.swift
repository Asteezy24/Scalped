//
//  IndividualPortfolioItemView.swift
//  Scalped
//
//  Created by Alexander Stevens on 2/9/21.
//

import SwiftUI

struct IndividualPortfolioItemView: View {
    
    let item: PortfolioItem
    
    var body: some View {
        Form {
            Section(header: Text("Underlying")) {
                Text(item.underlying)
            }
            Section(header: Text("Strategy")) {
                Text(item.type)
            }
            Section(header: Text("Date Bought")) {
                Text(item.dateBought)
            }
            Section(header: Text("Purchase Price")) {
                Text(item.purchasePrice)
            }
            Section(header: Text("Current Price")) {
                Text(item.currentPrice)
            }
            Section(header: Text("Current PL")) {
                Text(item.currentPL)
            }
        }
    }
}

struct IndividualPortfolioItemView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualPortfolioItemView(item: PortfolioItem(underlying: "", currentPrice: "", currentPL: "", dateBought: "", purchasePrice: "", type: ""))
    }
}
