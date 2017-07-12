//
//  AppGlobal.swift
//  BSL Hands One
//
//  Created by Arbab.Rashid on 27/06/2017.
//  Copyright © 2017 Thomas Maher. All rights reserved.
//

import Foundation
import UIKit

class AppGlobal {
    
    static func isIPhone() ->Bool {
        
        if(UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone){
            return true
        }
        else{
            return false
        }
    }
    
    static func isLandscape() -> Bool {
        
        if UIDevice.current.orientation.isLandscape {
            return true
        }
        else{
            return false
        }
    }
    
}

public enum DisplayType {
    case unknown
    case iphone4
    case iphoneSE
    case iphone6
    case iphone6plus
    static let iphone7 = iphone6
    static let iphone7plus = iphone6plus
    case ipad9
    case ipad12
}

public final class Display {
    class var width:CGFloat { return UIScreen.main.bounds.size.width }
    class var height:CGFloat { return UIScreen.main.bounds.size.height }
    class var maxLength:CGFloat { return max(width, height) }
    class var minLength:CGFloat { return min(width, height) }
    class var zoomed:Bool { return UIScreen.main.nativeScale >= UIScreen.main.scale }
    class var retina:Bool { return UIScreen.main.scale >= 2.0 }
    class var phone:Bool { return UIDevice.current.userInterfaceIdiom == .phone }
    class var pad:Bool { return UIDevice.current.userInterfaceIdiom == .pad }
    class var carplay:Bool { return UIDevice.current.userInterfaceIdiom == .carPlay }
    class var tv:Bool { return UIDevice.current.userInterfaceIdiom == .tv }
    class var typeIsLike:DisplayType {
        if phone && maxLength < 568 {
            return .iphone4
        }
        else if phone && maxLength == 568 {
            return .iphoneSE
        }
        else if phone && maxLength == 667 {
            return .iphone6
        }
        else if phone && maxLength == 736 {
            return .iphone6plus
        }
        if pad && maxLength == 1024 {
            return .ipad9
        }
        else if pad && maxLength == 1366 {
            return .ipad12
        }
        
        return .unknown
    }
}
