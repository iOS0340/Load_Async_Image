//
//  PhotosViewModel.swift
//  async_image_load
//
//  Created by Bhavesh Patel on 15/04/24.
//

import Foundation

enum Event {
    case loading
    case loaded
    case stopLoading
    case allImagesLoaded
    case failure(BHError?, Int?)
} // ENUM is created for event handling functionality.

class PhotosViewModel {
    
    var photos : [Photos] = []
    var event : ((_ eve : Event) -> Void)?
    
    private var currentPage = 0
    private var allPageLoaded = false
    
    func fetchPhotosFromServer () {
        
        guard isNetworkAvailable else {
            self.event?(.failure(BHError.noInternet, URLError.Code.notConnectedToInternet.rawValue))
            return
        }
        
        guard !allPageLoaded else {
            self.event?(.allImagesLoaded)
            return
        }
        
        self.event?(.loading)
        
        let pageNumber = currentPage + 1
        
        let endPoint = "\(PHOTOS_END_POINT)"+"\(CLIENT_ID)"+"&per_page=\(PER_PAGE_IMAGE_COUNT)"+"&page=\(pageNumber)"
                
        APIManager.shared.getPhotos(endpoint: endPoint) { (result : Result<[Photos], BHError>) in
            self.event?(.stopLoading)
            switch result {
            case.success(let photos):
                if (self.currentPage != pageNumber) {
                    self.photos.append(contentsOf: photos)
                    self.currentPage = pageNumber
                    self.event?(.loaded)
                }
                else {
                    self.event?(.allImagesLoaded)
                    self.allPageLoaded = true
                }
                break;
            case .failure(let error):
                print(error)
                self.event?(.failure(error, (error as NSError).code))
                break;
            }
        }
    }
    
}
