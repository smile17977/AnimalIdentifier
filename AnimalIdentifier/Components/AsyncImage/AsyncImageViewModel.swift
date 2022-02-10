//
//  AsyncImageViewModel.swift
//  AnimalIdentifier
//
//  Created by Kirill Presnyakov on 02.02.2022.
//

import Foundation
import Combine
import UIKit

final class AsyncImageViewModel: ObservableObject {
    @Published var image: UIImage?
    
    private let loader = ImageLoader.shared
    
    private var disposables = Set<AnyCancellable>()
    
    init(url: String) {
        loadImage(url: url)
    }
    
    private func loadImage(url: String) {
        guard let url = URL(string: url) else { return }
        loader
            .loadImage(from: url)
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { [weak self] image in
                self?.image = image
            }
            .store(in: &disposables)
    }
}
