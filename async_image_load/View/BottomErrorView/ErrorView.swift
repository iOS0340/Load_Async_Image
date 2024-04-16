//
//  ErrorView.swift
//  async_image_load
//
//  Created by Bhavesh Patel on 16/04/24.
//

import UIKit

class ErrorView: UIView {

    @IBOutlet weak var lblMessage : UILabel!
    
    static func loadViewFromNib() -> UIView {
                let view: ErrorView = initFromNib()
                return view
    }
    
    
//    Action is to remove view from window on Cross button click
    
    @IBAction func removeErrorViewFromSubview (sender : UIButton) -> Void {
        self.removeFromSuperview()
        AppDelegate.sharedObj.errorView = nil
    }
    
}

extension UIView {
    class func initFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?[0] as! T
    }
}
