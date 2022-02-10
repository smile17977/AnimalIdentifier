//
//  AnimalCheckViewModel.swift
//  AnimalIdentifier
//
//  Created by Kirill Presnyakov on 10.02.2022.
//

import Foundation
import Combine
import Vision

final class AnimalCheckViewModel: ObservableObject {
    @Published var imageVM: AsyncImageViewModel
    @Published var results: [VNClassificationObservation]?
    
    let loader = ImageLoader.shared
    
    private var disposables = Set<AnyCancellable>()
    
    init(imageVM: AsyncImageViewModel) {
        self.imageVM = imageVM
    }
    
    func onAppear() {
        bind()
    }
    
    func checkAnimal() {
        guard
            let animals = try? Animals(configuration: .init()),
            let model = try? VNCoreMLModel(for: animals.model),
            let image = imageVM.image
        else {
            return
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            if let results = request.results as? [VNClassificationObservation] {
                self.add(results)
            } else {
                print(error)
            }
        }
        
        let handler = VNImageRequestHandler(cgImage: image.cgImage!)
        try? handler.perform([request])
    }
    
    func bind() {
        imageVM
            .$image
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.checkAnimal()
            }
            .store(in: &disposables)
    }
    
    private func add(_ results: [VNClassificationObservation]) {
        self.results = results.filter { ($0.confidence * 100) > 10 }
    }
}
