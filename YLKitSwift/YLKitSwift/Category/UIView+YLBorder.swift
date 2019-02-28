//
//  UIView+Border.swift
//  YLKitSwift
//
//  Created by Yeonluu on 2018/12/20.
//  Copyright © 2018年 Yeonluu. All rights reserved.
//

import UIKit

fileprivate let DashedLayerName = "DashedLayer"

extension UIView {
    
    /// 添加虚线框
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - cornerRadius: 圆角
    @objc func addDashedBorder(color: UIColor = .gray, cornerRadius: CGFloat = 6) {
       self.addDashedBorder(color: color, lineWidth: 1, lineDashPattern: [2, 4], cornerRadius: cornerRadius)
    }
    
    
    /// 添加虚线框
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - lineWidth: 线宽
    ///   - lineDashPattern: 线间距
    ///   - cornerRadius: 圆角
    /// - Returns: 虚线框图层
    @discardableResult
    public func addDashedBorder(color: UIColor = .gray, lineWidth: CGFloat = 1.0, lineDashPattern: [Float] = [2, 4], cornerRadius: CGFloat = 6) -> CAShapeLayer {
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        let dashedLayer = CAShapeLayer.dashedLayerWith(frame: bounds, color: color, lineWidth: lineWidth, lineDashPattern: lineDashPattern, cornerRadius: cornerRadius)
        self.layer.addSublayer(dashedLayer)
        return dashedLayer
    }
    
    /// 添加单边圆角
    ///
    /// - Parameters:
    ///   - corners: 单边方向
    ///   - cornerRadius: 圆角
    /// - Returns: 单边圆角图层
    @discardableResult
    public func addRoundedBorders(corners: UIRectCorner, cornerRadius: CGFloat = 6) -> CAShapeLayer {
        let maskPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
        return maskLayer
    }
    
    /// 添加单个边框
    ///
    /// - Parameters:
    ///   - edges: 单边方向
    ///   - color: 颜色
    ///   - inset: 缩进
    ///   - lineWidth: 线宽
    /// - Returns: 单个边框图层
    @discardableResult
    public func addBorders(edges: UIRectEdge, color: UIColor = .gray, inset: CGFloat = 0.0, lineWidth: CGFloat = 1.0) -> [UIView] {
        var borders = [UIView]()
        @discardableResult
        func addBorder(formats: String...) -> UIView {
            let border = UIView(frame: .zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            addSubview(border)
            addConstraints(formats.flatMap {
                NSLayoutConstraint.constraints(withVisualFormat: $0, options: [], metrics: ["inset": inset, "thickness": lineWidth], views: ["border": border])
            })
            borders.append(border)
            return border
        }
        
        if edges.contains(.top) || edges.contains(.all) {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }
        return borders
    }
}


extension CAShapeLayer {
    
    /// 获取虚线框图层
    ///
    /// - Parameters:
    ///   - frame: 位置
    ///   - color: 颜色
    ///   - lineWidth: 线宽
    ///   - lineDashPattern: 线间距
    ///   - cornerRadius: 圆角
    /// - Returns: 虚线框图层
    class func dashedLayerWith(frame: CGRect, color: UIColor, lineWidth: CGFloat = 1, lineDashPattern: [Float] = [2, 4], cornerRadius: CGFloat = 6) -> CAShapeLayer{
        
        let layer = CAShapeLayer()
        layer.frame = frame
        layer.strokeColor = color.cgColor
        layer.fillColor = nil
        layer.lineWidth = lineWidth
        layer.lineDashPattern = lineDashPattern as [NSNumber]
        layer.lineCap = .square
        layer.lineJoin = .round
        layer.path = UIBezierPath(roundedRect: frame, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath

//            UIBezierPath(roundedRect: frame, cornerRadius: cornerRadius).cgPath
        
        layer.name = DashedLayerName
        return layer
    }
    
    /// 重新绘制
    public func fillPath() {
        if let superlayer = self.superlayer {
            self.path = UIBezierPath(roundedRect: superlayer.bounds, cornerRadius: superlayer.cornerRadius).cgPath
        }
    }
}
