//
//  ImageService.swift
//  CSTV
//
//  Created by João Tribuzy on 02/09/24.
//

import Foundation

protocol ImageServicing {
    func fetchDataImageURL(from url: URL?) async throws -> URL?
}

final class ImageService: ImageServicing {
    private var networkManager: NetworkManaging
    
    init(networkManager: NetworkManaging = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchDataImageURL(from url: URL?) async throws -> URL? {
        let encodedString = try await networkManager.getEncodedUrlString(for: url)
        return  URL(string: "data:image/png;base64," + encodedString)
    }
}
