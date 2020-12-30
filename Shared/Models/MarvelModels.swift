//
//  MarvelModels.swift
//  herosMarvel
//
//  Created by JOSE LUIS BUSTOS ESTEBAN on 30/12/20.
//

import Foundation

/*
 Generar los modelos desde esta URL:
 https://quicktype.io
 */

struct MarvelModel: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataMarvel?
}

struct DataMarvel: Codable {
    let offset, limit, total, count: Int
    let results: [records]?
}
struct records: Codable , Hashable{
    static func == (lhs: records, rhs: records) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: Int
    let name: String?
    let description: String?
    let title: String?
    let thumbnail: Thumbnail
    let resourceURI: String?
}


struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
    
    func getURLDownloadImage() -> String {
        return "\(path)/portrait_xlarge.\(thumbnailExtension)"
    }
}

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
    case png = "png"
}
