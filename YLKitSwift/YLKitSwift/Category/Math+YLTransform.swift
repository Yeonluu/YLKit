//
//  Double+Transform.swift
//  YLKitSwift
//
//  Created by Yeonluu on 2019/2/22.
//  Copyright © 2019 Yeonluu. All rights reserved.
//

import CoreGraphics
import Foundation

extension Double {
    
    /// 去除小数点后多余的0 例如:9.9 -9.9
    var priceValue: String {
        var string = String(format: "%.2f", self)
        if string.hasSuffix("0") { // 8.00 —> 8.0
            string = string.substring(to: string.count-1)
            if string.hasSuffix("0") { // 8.0 -> 8
                string = string.substring(to: string.count-2)
            }
        }
        return string
    }
    
    /// ¥ + 保留两位小数
    var rmbFixedValue: String {
        return String(format: "¥%.2f", self)
    }
    
    /// ¥ + 负数 保留两位小数
    var rmbFixedMinusValue: String {
        return String(format: "-¥%.2f", self)
    }
}

extension Int {

    var f: CGFloat {
        return CGFloat(self)
    }
}

