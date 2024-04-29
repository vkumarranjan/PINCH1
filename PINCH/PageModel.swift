//
//  PageModel.swift
//  PINCH
//
//  Created by vinay Kumar ranjan on 29/04/24.
//

import Foundation


struct Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page {
    
    var thumbnailName: String {
        return "thumb-" + imageName
    }
}
