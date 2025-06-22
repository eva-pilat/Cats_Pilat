//
//  CatViewModel.swift
//  App
//
//  Created by Єва Матвєєва on 26.05.2025.
//

import Foundation
import Networking

enum AnimalMode: String {
    case cats = "CATS"
    case dogs = "DOGS"
}

class CatViewModel: ObservableObject {
    @Published var cats: [String] = []
    @Published var isLoading = false

    private let pageSize = 20
    private let animalMode: AnimalMode

    init() {
        if let mode = Bundle.main.object(forInfoDictionaryKey: "AnimalMode") as? String,
            let animalMode = AnimalMode(rawValue: mode) {
                self.animalMode = animalMode
            } else {
                self.animalMode = .dogs
            }
        loadMoreCats()
    }

    public func loadMoreCats() {
        print("im alive!")
        guard !isLoading else { return }
        isLoading = true
        
        let fetchFunction = animalMode == .cats ? NetworkManager.getCats : NetworkManager.getDogs
        
        fetchFunction(pageSize) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                print("idu v network")
                switch result {
                    case .success(let urls):
                        self.cats.append(contentsOf: urls)
                        self.isLoading = false
                    case .failure(let error):
                        print("Error fetching cats:", error)
                        self.isLoading = false
                }
            }
        }

//        Task { [weak self] in
//            guard let self = self else { return }
//            let pageSize = self.pageSize
//            do {
//                let urls = try await NetworkManager.getCatsAsync(limit: pageSize)
//                await MainActor.run {
//                    self.cats.append(contentsOf: urls)
//                    self.isLoading = false
//                }
//            } catch {
//                await MainActor.run {
//                    print("Error fetching cats:", error)
//                    self.isLoading = false
//                }
//            }
//        }
    }
}
