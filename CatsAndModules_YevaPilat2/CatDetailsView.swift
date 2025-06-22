//
//  SwiftUIView.swift
//  App
//
//  Created by Єва Матвєєва on 26.05.2025.
//

import SwiftUI
import FirebasePerformance

struct CatDetailsView: View {
    
    let imageURL: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)!){ image in
            let trace = Performance.startTrace(name: "load_image_trace")
            defer { trace?.stop() }
            return image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
            
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("", displayMode: .inline)
    }
}

#Preview {
    //CatDetailsView()
}
