//
//  URL+Extensions.swift
//  CSTV
//
//  Created by João Tribuzy on 31/08/24.
//

import Foundation

extension URL {
    func getThumbUrl() -> URL? {
        var urlParts = self.absoluteURL.absoluteString.split(separator: "/").map { return "\($0)" }
        
        guard !urlParts.isEmpty, let fileName = urlParts.last else { return nil }
        
        urlParts[urlParts.count - 1] = "thumb_\(fileName)"
        
        return URL(string: urlParts.joined(separator: "/"))
    }
}
