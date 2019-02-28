//
//  UIColor+Extension.swift
//  YLKitSwift
//
//  Created by Yeonluu on 2018/8/3.
//  Copyright © 2018年 Yeonluu. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func RGB(_ rgb: CGFloat) -> UIColor {
        return UIColor.init(red: rgb/255, green: rgb/255, blue: rgb/255, alpha: 1)
    }
    
    class func RGB(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    class func RGBA(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
