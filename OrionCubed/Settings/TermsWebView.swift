//
//  TermsWebView.swift
//  Scalped
//
//  Created by Alexander Stevens on 1/24/21.
//
import SwiftUI
import WebKit


struct WebView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let htmlFile = Bundle.main.path(forResource: "terms", ofType: "html")
        let htmlString = try? String(contentsOfFile: htmlFile!, encoding: String.Encoding.utf8)
        uiView.loadHTMLString(htmlString!, baseURL: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        WebView()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}
