//
//  Photos.swift
//  async_image_load
//
//  Created by Bhavesh Patel on 15/04/24.
//

import Foundation

class Photos: Codable, Identifiable {
    let id : String
    let description : String?
    var urls : URLS
}

class URLS: Codable {
    let full : String
    let small : String
    var thumb : String
    let regular : String
}
