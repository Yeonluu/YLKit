//
//  UIImage+Brightness.swift
//  YLKitSwift
//
//  Created by Yeonluu on 2018/12/28.
//  Copyright © 2018年 Yeonluu. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// 是否为亮色
    ///
    /// - Parameter rect: 区域
    public func isBright(inRect rect: CGRect?) -> Bool {
        guard let image = image else {
            return false
        }
        var newImage = image
        if let rect = rect, let new = self.croppingImage(to: rect) {
            newImage = new
        }
        newImage = newImage.compressImage(limitWidth: 50)
        let width = Int(newImage.size.width), height = Int(newImage.size.height)
        let totalCount =  width*height
        var colorsMap = [String: Int]()
        var maxCount = 0
        var maxColors: [Int] = []
        guard let pixelData = newImage.cgImage?.dataProvider?.data, let data = CFDataGetBytePtr(pixelData) else {
            return false
        }
        for x in 1...width {
            for y in 1...height {
                let offset = 4*x*y
                let r = Int(data[offset])
                let g = Int(data[offset+1])
                let b = Int(data[offset+2])
                let a = Int(data[offset+3])
                let colors = [r, g, b, a]
                let key = "\(r)\(g)\(b)\(a)"
                let count = (colorsMap[key] ?? 0) + 1
                if count > maxCount {
                    maxCount = count
                    maxColors = colors
                }
                colorsMap[key] = count
                if count >= totalCount/2 {
                    return UIColor.RGBA(r.f, g.f, b.f, a.f).isBright()
                }
            }
        }
        return UIColor.RGBA(maxColors[0].f, maxColors[1].f, maxColors[2].f, maxColors[3].f).isBright()
    }
    
    /// 裁剪图片
    ///
    /// - Parameter rect: 区域
    public func croppingImage(to rect: CGRect) -> UIImage? {
        
        if let image = image {
            let scale = image.size.width/self.frame.size.width*image.scale
            let newCGImage = image.fixOrientation().cgImage?.cropping(to: CGRect(x: rect.origin.x*scale, y: rect.origin.y*scale, width: rect.size.width*scale, height: rect.size.height*scale))
     
            if let newCGImage = newCGImage {
                return UIImage.init(cgImage: newCGImage)
            }
        }
        return nil
    }
    
}

fileprivate extension UIImage {
    
    /// 压缩图片
    ///
    /// - Parameters:
    ///   - limitWidth: 限宽
    ///   - limitHeight: 限高
    func compressImage(limitWidth: CGFloat? = nil, limitHeight: CGFloat? = nil) -> UIImage {
        var width: CGFloat, height: CGFloat
        if let limitWidth = limitWidth {
            width = limitWidth
            height = size.height*limitWidth/size.width
        }
        else if let limitHeight = limitHeight {
            width = size.width*limitHeight/size.height
            height = limitHeight
        }
        else {
            return self
        }
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage ?? self
    }
    
    /// 自适配图片方向
    func fixOrientation() -> UIImage {
        
        guard let cgImage = cgImage else { return self }
        
        if imageOrientation == .up { return self }
        
        var transform = CGAffineTransform.identity
        
        switch imageOrientation {
            
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
            
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi/2))
            
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat(-Double.pi/2))
            
        case .up, .upMirrored:
            break
        }
        
        switch imageOrientation {
            
        case .upMirrored, .downMirrored:
            transform.translatedBy(x: size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
            
        case .leftMirrored, .rightMirrored:
            transform.translatedBy(x: size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
            
        case .up, .down, .left, .right:
            break
        }
        
        if let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: cgImage.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) {
            
            ctx.concatenate(transform)
            
            switch imageOrientation {
                
            case .left, .leftMirrored, .right, .rightMirrored:
                ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
                
            default:
                ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            }
            
            if let finalImage = ctx.makeImage() {
                return (UIImage(cgImage: finalImage))
            }
        }
        
        // something failed -- return original
        return self
    }
}


fileprivate extension UIColor {
    
    /// 是否亮色
    func isBright() -> Bool {
        if self.alpha() < 10e-5 {
            return false
        }
        if let componens = self.cgColor.components {
            let brightness = ((componens[0] * 299) + (componens[1] * 587) + (componens[2] * 114)) / 1000;
            return (brightness > 0.66);
        }
        return false
    }
    
    private func alpha() -> CGFloat {
        var r = 0.f, g = 0.f, b = 0.f, a = 0.f, w = 0.f, h = 0.f, s = 0.f, l = 0.f
        if self.getWhite(&w, alpha: &a) {
            return a
        }
        else if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return a
        }
        else {
            self.getHue(&h, saturation: &s, brightness: &l, alpha: &a)
        }
        return a
    }
}
