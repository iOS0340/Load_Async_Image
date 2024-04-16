//
//  AppDelegate.swift
//  async_image_load
//
//  Created by Bhavesh Patel on 15/04/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var sharedObj: AppDelegate {
        get{
            return (UIApplication.shared.delegate as? AppDelegate)!
        }
    }
    
    var errorView : ErrorView?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        checkNetworkAvailability()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

//    Method is used to show error message to the user.
    
    func showErrorMessage (message : String) -> Void{
        DispatchQueue.main.async {
            guard self.errorView == nil else {
                self.errorView?.lblMessage.text = message
                return
            }
            
            let firstWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first;
            
            self.errorView = ErrorView.loadViewFromNib() as? ErrorView
            
            self.errorView?.frame.origin = CGPoint(x: 0, y: (firstWindow!.frame.size.height) - 50)
            self.errorView?.frame.size.width = firstWindow!.frame.size.width
            
            self.errorView?.lblMessage.text = message
            
            firstWindow!.addSubview(self.errorView!);
        }
    }
    
//    Mathod is to remove Already added Error Message from window
    
    func removeErrorMessage() -> Void {
        DispatchQueue.main.async {
            guard self.errorView != nil else {
                return
            }
            self.errorView!.removeFromSuperview()
            self.errorView = nil
        }
    }

}

