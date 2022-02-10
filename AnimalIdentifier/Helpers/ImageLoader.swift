//
//  ImageLoader.swift
//  AnimalIdentifier
//
//  Created by Kirill Presnyakov on 02.02.2022.
//

import Combine
import SwiftUI

final class ImageLoader {
    static let shared = ImageLoader()
    
    private init() {}
    
    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Error> {
        let request = URLRequest(url: url)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { (data, response) -> UIImage? in
                return UIImage(data: data)
            }
            .mapError { $0 }
            .print("Image loading: \(url)")
            .subscribe(on: DispatchQueue.global())
            .eraseToAnyPublisher()
    }
}

