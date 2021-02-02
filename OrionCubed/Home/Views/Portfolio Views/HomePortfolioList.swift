//
//  HomePortfolioList.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 1/30/21.
//

import SwiftUI

struct HomePortfolioList: View {
    
    let portfolio: [PortfolioItem]
    let tapAction: () -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 10) {
                ForEach((0..<portfolio.count), id: \.self, content: { index in
                    PortfolioListItem(item: portfolio[index]).onTapGesture(perform: tapAction)
                })
            }
        }
    }
}

struct HomePortfolioList_Previews: PreviewProvider {
    static var previews: some View {
        HomePortfolioList(portfolio: [], tapAction: {})
    }
}
