//
//  NSCacheSubscript.swift
//  Earthquakes
//
//  Created by Zack Williams on 05/10/2024.
//

import Foundation

extension NSCache where KeyType == NSString, ObjectType == CacheEntryObject {
    subscript(_ url: URL) -> CacheEntry? {
        get{
            let key = url.absoluteString as NSString
            let value = object(forKey: key)
            
            return value?.entry
        }
        
        set {
            let key = url.absoluteString as NSString
            if let entry = newValue {
                let value = CacheEntryObject(entry: entry)
                setObject(value, forKey: key)
            } else {
                removeObject(forKey: key)
            }
        }
    }
}
