//
//  FlickrImage.swift
//  FlickrChallenge
//
//  Created by Marco Abundo on 11/20/24.
//

import Foundation

struct FlickrImage: Codable, Identifiable {
    let id = UUID()
    let title: String
    let media: Media
    let link: String
    let description: String
    let author: String
    let dateTaken: String

    struct Media: Codable {
        let m: String
    }

    enum CodingKeys: String, CodingKey {
        case title
        case media
        case link
        case description
        case author
        case dateTaken = "dateTaken"
    }
}

struct FlickrResponse: Codable {
    let items: [FlickrImage]
}
