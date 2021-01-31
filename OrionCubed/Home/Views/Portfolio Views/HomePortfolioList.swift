//
//  HomePortfolioList.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 1/30/21.
//

import SwiftUI

struct HomePortfolioList: View {
    
    let tapAction: () -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 10) {
                ForEach((0..<10), id: \.self, content: { index in
                    PortfolioListItem().onTapGesture(perform: tapAction)
                })
            }
        }
//        List {

//        }
//        .padding(.top,  16)
//        .listStyle(InsetListStyle())
        
    }
}

struct HomePortfolioList_Previews: PreviewProvider {
    static var previews: some View {
        HomePortfolioList(tapAction: {})
    }
}
