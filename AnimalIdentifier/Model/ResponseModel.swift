//
//  ResponseModel.swift
//  AnimalIdentifier
//
//  Created by Kirill Presnyakov on 09.02.2022.
//

struct ResponseModel: Decodable {
    let page: Int
    let perPage: Int
    let photos: [AnimalModel]
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case photos
    }
}
