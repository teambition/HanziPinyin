//
//  HanziPinyinResource.swift
//  HanziPinyin
//
//  Created by Xin Hong on 16/4/16.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import Foundation

internal extension HanziPinyin {
    internal static var unicodeToPinyinTable: [String: String] {
        if let cachedPinyinTable = cachedObjectForKey(CacheKeys.unicodeToPinyin) as? [String: String] {
            return cachedPinyinTable
        } else {
            let resourceBundle = NSBundle(identifier: "Teambition.HanziPinyin") ?? NSBundle.mainBundle()
            guard let resourcePath = resourceBundle.pathForResource("unicode_to_hanyu_pinyin", ofType: "txt") else {
                return [:]
            }

            do {
                let unicodeToPinyinText = try NSString(contentsOfFile: resourcePath, encoding: NSUTF8StringEncoding) as String
                let textComponents = unicodeToPinyinText.componentsSeparatedByString("\r\n")

                var pinyinTable = [String: String]()
                for pinyin in textComponents {
                    let components = pinyin.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                    guard components.count > 1 else {
                        continue
                    }
                    pinyinTable.updateValue(components[1], forKey: components[0])
                }

                cacheObject(pinyinTable, forKey: CacheKeys.unicodeToPinyin)
                return pinyinTable
            } catch _ {
                return [:]
            }
        }
    }

    internal static func pinyinForCharCodePoint(charCodePoint: UInt32) -> [String] {
        func isValidPinyin(pinyin: String) -> Bool {
            return pinyin != "(none0)" && pinyin.hasPrefix("(") && pinyin.hasSuffix(")")
        }

        let codePointHex = String(format: "%x", charCodePoint).uppercaseString
        guard let pinyin = unicodeToPinyinTable[codePointHex] where isValidPinyin(pinyin) else {
            return []
        }

        let leftBracketRange = pinyin.rangeOfString("(")!
        let rightBracketRange = pinyin.rangeOfString(")")!
        let processedPinyin = pinyin.substringWithRange(Range(start: leftBracketRange.endIndex, end: rightBracketRange.startIndex))
        return processedPinyin.componentsSeparatedByString(",")
    }
}

internal extension HanziPinyin {
    private static var pinYinCachePath: String? {
        guard let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first as? NSString else {
            return nil
        }
        
        let pinYinCachePath = documentsPath.stringByAppendingPathComponent("PinYinCache")
        if !NSFileManager.defaultManager().fileExistsAtPath(pinYinCachePath) {
            do {
                try NSFileManager.defaultManager().createDirectoryAtPath(pinYinCachePath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("create pinYin cache path error: \(error)")
                return nil
            }
        }
        return pinYinCachePath
    }

    private static func pinYinCachePathForKey(key: String) -> String? {
        guard let pinYinCachePath = pinYinCachePath as? NSString else {
            return nil
        }
        return pinYinCachePath.stringByAppendingPathComponent(key)
    }

    private static func cacheObject(object: NSCoding, forKey key: String) {
        let archivedData = NSKeyedArchiver.archivedDataWithRootObject(object)
        guard let cachePath = pinYinCachePathForKey(key) else {
            return
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { 
            do {
                try archivedData.writeToFile(cachePath, options: .AtomicWrite)
            } catch let error {
                print("cache object error: \(error)")
            }
        }
    }

    private static func cachedObjectForKey(key: String) -> NSCoding? {
        guard let cachePath = pinYinCachePathForKey(key) else {
            return nil
        }
        do {
            let data = try NSData(contentsOfFile: cachePath, options: [])
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? NSCoding
        } catch let error {
            print("get cached object error: \(error)")
            return nil
        }
    }
}
