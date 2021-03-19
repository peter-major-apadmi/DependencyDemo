//
//  DogImagesResponse.swift
//  DependencyDemo
//
//  Created by Peter Major on 18/03/2021.
//

import Foundation

struct DogImagesResponse: Decodable {
    let message: [String]
    let status: String
}
