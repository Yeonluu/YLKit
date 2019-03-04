

//
//  Dictionary+Data.swift
//  YLKitSwift
//
//  Created by Yeonluu on 2018/8/3.
//  Copyright © 2018年 Yeonluu. All rights reserved.
//

extension Dictionary {
    
    public func getDict(_ key: String?) -> [String : Any]? {
        guard let key = key, key.count > 0 else {
            return self as? [String : Any]
        }
        return (self as! [String : Any])[key] as? [String : Any]
    }
    
    public func getList(_ key: String?) -> [Any]? {
        guard let key = key, key.count > 0 else {
            return []
        }
        return (self as! [String : Any])[key] as? [Any]
    }
    
    public func getValue(_ key: String?) -> Any? {
        guard let key = key, key.count > 0 else {
            return nil
        }
        return (self as! [String : Any])[key]
    }
    
    public func getString(_ key: String?) -> String? {
        return getValue(key) as? String
    }
}

