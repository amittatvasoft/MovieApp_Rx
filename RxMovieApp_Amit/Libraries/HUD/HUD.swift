//
//  HUD.swift
//  AMIT
//
//  Created by MAC-209 on 9/15/16.
//  Copyright © 2016 MAC-209. All rights reserved.
//

import UIKit

class HUD: UIView {

    static private var backGroundView: UIView?
    static var progressTintColor = UIColor.black
    
    class func show() {
        HUD.hide()
        DispatchQueue.main.async {
            
            backGroundView = UIView(frame: (UIApplication.shared.delegate)!.window!!.bounds)
            backGroundView!.backgroundColor = UIColor.black.withAlphaComponent(0.5)

            let indicatorView = IndicatorView(progressIndicatorColor: HUD.progressTintColor)
            backGroundView!.addSubview(indicatorView)
            indicatorView.center = (backGroundView?.center)!
            
            (UIApplication.shared.delegate)!.window!!.addSubview(backGroundView!)
        }
    }
    
    class func hide() {
        DispatchQueue.main.async {
            backGroundView?.removeFromSuperview()
        }
    }
}

class IndicatorView: UIView {
    var progressIndicatorColor : UIColor!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(progressIndicatorColor: UIColor) {
        super.init(frame: CGRect(x: 0, y: 0, width: 40.0, height: 40.0))
        self.progressIndicatorColor = progressIndicatorColor
        
        self.initIndicatorView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initIndicatorView() {
        let spinnerView = MMMaterialDesignSpinner(frame: self.frame)
        spinnerView.lineWidth = 3.5// 4.5
        spinnerView.tintColor = self.progressIndicatorColor
        self.addSubview(spinnerView)
        
        spinnerView.startAnimating()
    }
}
