//
//  Cat.swift
//  Networking
//
//  Created by Єва Матвєєва on 26.05.2025.
//

import Foundation

public struct Cat: Codable {
    let id: String?
    let width: Int?
    let height: Int?
    let url: String
    let breeds: [Breeds]?
}

public struct Breeds: Codable {
    let weight: Weight?
    let height: Height?
    let id: String?
    let name: String?
    let temperament: String?
    let origin: String?
    let country_codes: String?
    let country_code: String?
    let life_span: String?
    let wikipedia_url: String?
    let reference_image_id: String?
    
    enum CodingKeys: String, CodingKey {
        case weight, id, name, temperament, origin, country_codes, country_code, life_span, wikipedia_url, reference_image_id, height
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        weight = try container.decodeIfPresent(Weight.self, forKey: .weight)
        height = try container.decodeIfPresent(Height.self, forKey: .height)
        
        if let intId = try? container.decode(Int.self, forKey: .id) {
            id = String(intId)
        } else {
            id = try container.decode(String.self, forKey: .id)
        }

        name = try container.decodeIfPresent(String.self, forKey: .name)
        temperament = try container.decodeIfPresent(String.self, forKey: .temperament)
        origin = try container.decodeIfPresent(String.self, forKey: .origin)
        country_codes = try? container.decodeIfPresent(String.self, forKey: .country_codes)
        country_code = try container.decodeIfPresent(String.self, forKey: .country_code)
        life_span = try container.decode(String.self, forKey: .life_span)
        wikipedia_url = try container.decodeIfPresent(String.self, forKey: .wikipedia_url)
        reference_image_id = try container.decodeIfPresent(String.self, forKey: .reference_image_id)
        
    }
    
}

public struct Weight: Codable {
    let imperial: String
    let metric: String
}

public struct Height: Codable {
    let imperial: String
    let metric: String
}


