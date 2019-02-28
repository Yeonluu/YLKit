//
//  String+SubString.swift
//  YLKitSwift
//
//  Created by Yeonluu on 2018/6/9.
//  Copyright © 2018年 Yeonluu. All rights reserved.
//

import Foundation

// substring
extension String {
    
    public func substring(from index: Int) -> String {
        guard self.count > index else {
            return self
        }
        let startIndex = self.index(self.startIndex, offsetBy: index)
        let subString = self[startIndex...]
        return String(subString)
    }
    
    public func substring(to index: Int) -> String {
        guard self.count > index else {
            return self
        }
        let endIndex = self.index(self.startIndex, offsetBy: index)
        let subString = self[..<endIndex]
        return String(subString)
    }
    
    public func substring(with range: CountableClosedRange<Int>) -> String {
        return self.substring(to: range.upperBound).substring(from: range.lowerBound)
    }
}

// priceString
extension String {
    
    /// 人民币样式字符串 例如:¥9.90 -¥9.90
    var rmbValue: String {
        if self.doubleValue >= 0 {
            return "¥" + self
        }
        return "-¥"+self.substring(from: 1)
    }
    
    /// 去除小数点后多余的0 例如:9.9 -9.9
    var priceValue: String {
        return self.doubleValue.priceValue
    }
    
    /// 去除小数点后多余的0 例如:¥9.9 -¥9.9
    var rmbPriceValue: String {
        return self.priceValue.rmbValue
    }
    
    /// ¥ + 保留两位小数
    var rmbFixedValue: String {
        return self.doubleValue.rmbFixedValue
    }
    
    /// ¥ + 负数 保留两位小数
    var rmbFixedMinusValue: String {
        return self.doubleValue.rmbFixedMinusValue
    }
}

// init
extension String {
    
    init?(_ value: Any?) {
        if let intV = value as? Int {
            self.init(intV)
        }
        else if let doubleV = value as? Double {
            self.init(doubleV)
        }
        else if let stringV = value as? String {
            self.init(stringV)
        }
        else {
            self.init()
        }
    }
    
    var intValue: Int {
        return Int(self) ?? 0
    }
    
    var doubleValue: Double {
        return Double(self) ?? 0
    }
    
    var floatValue: Float {
        return Float(self) ?? 0
    }
}

// check
extension String {
    
    public var isMobile: Bool {
        if self.count != 11 {
            return false
        }
        let phoneRegex = "^(1)[0-9]{10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return predicate.evaluate(with: self)
    }
    
    public var isErrorMobile: Bool {
        if !isMobile {
            print("请输入正确的11位手机号")
            return true
        }
        return false
    }
    
    public func formatMobile() -> String {
        var strings = [String]()
        var startIndex = 0
        [3, 4, 4].forEach { (subCount) in
            if startIndex + subCount <= self.count {
                strings.append(self.substring(with: startIndex...startIndex+subCount))
                startIndex += subCount
            }
            else {
                return
            }
        }
        return strings.joined(separator: " ")
    }
}


