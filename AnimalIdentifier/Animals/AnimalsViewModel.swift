//
//  AnimalsViewModel.swift
//  AnimalIdentifier
//
//  Created by Kirill Presnyakov on 02.02.2022.
//

import Foundation
import Combine

final class AnimalsViewModel: ObservableObject {
    
    @Published var models: [AnimalModel] = []
    @Published var currentPage: Int = 1
    
    private var isLoading: Bool = false
    
    private var disposables = Set<AnyCancellable>()
    
    init() {
        bind()
    }
    
    func bind() {
        load(page: currentPage)
    }
    
    func loadNextPage() {
        currentPage += 2
        load(page: currentPage)
    }
    
    func load(page: Int) {
        guard !isLoading else { return }
        
        isLoading = true
        
        guard let request = try? URLRequestBuilder(
            stringURL: "https://api.pexels.com/v1/search?page=\(page)&per_page=\(page + 1)&query=animals",
            headers: ["Authorization" : "563492ad6f917000010000015a8d3d2f97b24e38a1f3463b8d908041"]
        ).makeRequest() else { return }

        URLSession.shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: ResponseModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { [weak self] model in
                self?.models.append(contentsOf: model.photos)
                self?.isLoading = false
            }
            .store(in: &disposables)
    }
    
    func getImageVM(for url: String) -> AsyncImageViewModel {
        .init(url: url)
    }
}
