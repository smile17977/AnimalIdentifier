//
//  AnimalModel.swift
//  AnimalIdentifier
//
//  Created by Kirill Presnyakov on 02.02.2022.
//

import Foundation

struct AnimalModel: Decodable {
    let id: Int
    let url: String
    let photographer: String
    let src: Source
    let liked: Bool
    let alt: String
    
    struct Source: Decodable {
        let large: String
    }
}

extension AnimalModel: Identifiable { }

extension AnimalModel: Equatable {
    static func == (lhs: AnimalModel, rhs: AnimalModel) -> Bool {
        lhs.id == rhs.id
    }
}
