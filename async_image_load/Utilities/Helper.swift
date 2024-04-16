//
//  Helper.swift
//  async_image_load
//
//  Created by Bhavesh Patel on 16/04/24.
//

import Foundation
import Network


//  MARK: - Method is to check and update internet availability

func checkNetworkAvailability() -> Void {
    let monitor = NWPathMonitor()
    monitor.pathUpdateHandler = { path in
        if path.status == .satisfied {
            isNetworkAvailable = true
            DispatchQueue.main.async {
                AppDelegate.sharedObj.removeErrorMessage()
            }
        }
        else {
            isNetworkAvailable = false
            DispatchQueue.main.async {
                AppDelegate.sharedObj.showErrorMessage(message: NO_INTERNET)
            }            
        }
    }
    
    let queue = DispatchQueue(label: "NetworkMonitor")
    monitor.start(queue: queue)
}
