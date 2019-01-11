//
//  ActivityIndicatorViewable.swift
//  Movie_App
//
//  Created by MAC110 on 1/9/19.
//  Copyright © 2019 MAC110. All rights reserved.
//
import UIKit

protocol ActivityIndicatorViewable {
    
    func showActivityIndicator(in _containerView:UIView?) -> Void
    func hideActivityIndicator(from containerView:UIView?) -> Void
}
extension ActivityIndicatorViewable where Self: UIViewController {
    
    func showActivityIndicator(in _containerView:UIView? = nil) -> Void {

        HUD.show()
    }
    
    func hideActivityIndicator(from _containerView:UIView? = nil) -> Void {
        HUD.hide()
    }
}
