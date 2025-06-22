//
//  SwiftUIView.swift
//  App
//
//  Created by Єва Матвєєва on 26.05.2025.
//

import SwiftUI
import Foundation
import FirebasePerformance
import FirebaseCrashlytics

public struct CatsView: View {
    
    public init() {}
    
    @StateObject private var viewModel = CatViewModel()
    @State private var selectedCatIndex: Int? = nil
    @State private var showConsentAlert = false
    @AppStorage("hasShownConsent") private var hasShownConsent = false
    
    public var body: some View {
        NavigationView {
            ScrollView {
//                HStack {
//                    Button("Crash") {
//                        Crashlytics.crashlytics().log("Crash1 triggered: Fatal Error")
//                        Crashlytics.crashlytics().setCustomValue("FatalError", forKey: "crash_type")
//                        fatalError("Crash was triggered")
//                    }
//                    
//                    Button("Crash2") {
//                        Crashlytics.crashlytics().log("Crash2 triggered: Zero Division")
//                        Crashlytics.crashlytics().setCustomValue("ZeroDivision", forKey: "crash_type")
//                        let x = 10 / (Int.random(in: 0...1) == 0 ? 0 : 1)
//                    }
//                    
//                    Button("Crash3") {
//                        Crashlytics.crashlytics().log("Crash3 triggered: Nil Access")
//                        Crashlytics.crashlytics().setCustomValue("NilAccess", forKey: "crash_type")
//                        let array: [String]? = nil
//                        _ = array![0]
//                    }
//                }

                loadCats()
            }
            .accessibilityIdentifier("catsScrollView")
            .task {
                let trace = Performance.startTrace(name: "initial_load_cats_trace")
                viewModel.loadMoreCats()
                trace?.stop()
                            
                if !hasShownConsent {
                    showConsentAlert = true
                }
            }
            .alert(isPresented: $showConsentAlert) {
                Alert(
                    title: Text("Дозвіл на збір даних"),
                    message: Text("Дозволити збір даних про збої для покращення додатку?"),
                    primaryButton: .default(Text("Так")) {
                        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
                        hasShownConsent = true
                    },
                    secondaryButton: .cancel(Text("Ні")) {
                        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(false)
                        hasShownConsent = true
                    }
                )
            }
        }
    }
    
    @ViewBuilder func loadCats() -> some View {
        LazyVStack(alignment: .center, spacing: 20){
            ForEach(viewModel.cats.indices, id: \.self) { index in
                NavigationLink(destination: CatDetailsView(imageURL: viewModel.cats[index])) {
                    AsyncImage(url: URL(string: viewModel.cats[index])) { phase in
                        switch phase {
                            case .empty:
                                let trace = Performance.startTrace(name: "load_image_list_trace")
                            ProgressView()
                                .onDisappear {
                                    trace?.stop()
                                }
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 350, height: 200)
                                .cornerRadius(25)
                        case .failure:
                            Text("Failed to load image")
                        @unknown default:
                            EmptyView()
                        }
                    }
//                    .onTapGesture {
//                        Crashlytics.crashlytics().log("User tapped cat at index: \(index)")
//                        Crashlytics.crashlytics().setCustomValue(index, forKey: "selected_cat_index")
//                        selectedCatIndex = index
//                    }

                }
                .accessibilityIdentifier("catCell_\(index)")
                                
                if index == viewModel.cats.count - 1 {
                    Color.clear
                        .onAppear {
                            let trace = Performance.startTrace(name: "load_more_cats_trace")
                            viewModel.loadMoreCats()
                            trace?.stop()
                        }
                }
            }
        }
    }
    
}

#Preview {
    CatsView()
}
