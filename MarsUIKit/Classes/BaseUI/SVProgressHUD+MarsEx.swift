//
//  SVProgressHUD+MarsEx.swift
//  MarsUIKit
//
//  Created by Teng Fei on 2023/7/31.
//

import Foundation
#if os(iOS) || os(tvOS)
import UIKit
#if canImport(SVProgressHUD)
import SVProgressHUD

//MARK: - SVProgressHUDWrapable

@objc public protocol SVProgressHUDWrapable {
    // iOS || tvOS
    func ms_showProgressHUD(withStatus status: String?)
    func ms_showProgressHUD(withStatus status: String?, delay: TimeInterval)
    func ms_dismissProgressHUD()
    func ms_dismissProgressHUD(withDelay delay: TimeInterval)
}

extension MarsBase where Base : NSObject {
    
    /// Show progress HUD with the status.
    public func showProgressHUD(withStatus status: String?)
    {
        base.ms_showProgressHUD(withStatus: status)
    }
    
    /// Show progress HUD with the status and delay.
    public func showProgressHUD(withStatus status: String?, delay: TimeInterval)
    {
        base.ms_showProgressHUD(withStatus: status, delay: delay)
    }
    
    /// Dismiss progress HUD.
    public func dismissProgressHUD()
    {
        base.ms_dismissProgressHUD()
    }
    
    /// Dismiss progress HUD with the delay.
    public func dismissProgressHUD(withDelay delay: TimeInterval)
    {
        base.ms_dismissProgressHUD(withDelay: delay)
    }
    
}

extension NSObject: SVProgressHUDWrapable {
    
    //Set up.
    //SVProgressHUD.setDefaultStyle(.dark)
    //SVProgressHUD.setDefaultMaskType(.custom)
    //SVProgressHUD.setDefaultAnimationType(.flat)
    
    /// Show progress HUD with the status.
    public func ms_showProgressHUD(withStatus status: String?)
    {
        ms_showProgressHUD(withStatus: status, delay: 0)
    }
    
    /// Show progress HUD with the status and delay.
    public func ms_showProgressHUD(withStatus status: String?, delay: TimeInterval)
    {
        if delay > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                SVProgressHUD.show(withStatus: status)
            }
        } else {
            SVProgressHUD.show(withStatus: status)
        }
    }
    
    /// Dismiss progress HUD.
    public func ms_dismissProgressHUD()
    {
        ms_dismissProgressHUD(withDelay: 0.3)
    }
    
    /// Dismiss progress HUD with the delay.
    public func ms_dismissProgressHUD(withDelay delay: TimeInterval)
    {
        SVProgressHUD.dismiss(withDelay: delay)
    }
    
}

#endif
#endif
