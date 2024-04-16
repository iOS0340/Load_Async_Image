//
//  UIImageView+Extension.swift
//  async_image_load
//
//  Created by Bhavesh Patel on 15/04/24.
//

import UIKit

extension UIImageView {
    func load(url: URL, cache : URLCache? = nil) {
        
        let cache = cache ?? URLCache.shared
        
        guard let data = cache.cachedResponse(for: URLRequest.init(url: url))?.data , let image = UIImage.init(data: data) else {
            
            DispatchQueue.main.async {
                self.image = UIImage.init(named: "placeholder_image")
            }
            
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            print("Loaded direct from server")
                            self?.image = image
                        }
                    }
                }
                else {
                    DispatchQueue.main.async {
                        print("Loading Failed...")
                        self?.image = UIImage.init(named: "no_image_placeholder")
                    }
                }
            }
            return
        }
        
        DispatchQueue.main.async {
            print("Image Loaded from Cache")
            self.image = image
        }
    }
}
