//
//  HanziPinyinResource.swift
//  HanziPinyin
//
//  Created by Xin Hong on 16/4/16.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import Foundation

private struct CacheKeys {
    static let unicodeToPinyin = "HanziPinyin.UnicodeToPinyin"
}

internal extension HanziPinyin {
    private var podResourceBundle: Bundle? {
        guard let bundleURL = Bundle(for: WhateverClass.self).url(forResource: "HanziPinyin", withExtension: "bundle") else {
            return nil
        }
        return Bundle(url: bundleURL)
    }

    func initializeResource() -> [String: String] {
        if let cachedPinyinTable = HanziPinyin.cachedObject(forKey: CacheKeys.unicodeToPinyin) as? [String: String] {
            return cachedPinyinTable
        } else {
            let resourceBundle = podResourceBundle ?? Bundle(for: WhateverClass.self)
            guard let resourcePath = resourceBundle.path(forResource: "unicode_to_hanyu_pinyin", ofType: "txt") else {
                return [:]
            }

            do {
                let unicodeToPinyinText = try String(contentsOf: URL(fileURLWithPath: resourcePath))
                let textComponents = unicodeToPinyinText.components(separatedBy: "\r\n")

                var pinyinTable = [String: String]()
                for pinyin in textComponents {
                    let components = pinyin.components(separatedBy: .whitespaces)
                    guard components.count > 1 else {
                        continue
                    }
                    pinyinTable.updateValue(components[1], forKey: components[0])
                }

                HanziPinyin.cache(pinyinTable, forKey: CacheKeys.unicodeToPinyin)
                return pinyinTable
            } catch _ {
                return [:]
            }
        }
    }
}

internal extension HanziPinyin {
    fileprivate static var pinYinCachePath: String? {
        guard let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            return nil
        }

        let pinYinCachePath = NSString(string: documentsPath).appendingPathComponent("PinYinCache")
        if !FileManager.default.fileExists(atPath: pinYinCachePath) {
            do {
                try FileManager.default.createDirectory(atPath: pinYinCachePath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("create pinYin cache path error: \(error)")
                return nil
            }
        }
        return pinYinCachePath
    }

    fileprivate static func pinYinCachePath(forKey key: String) -> String? {
        guard let pinYinCachePath = pinYinCachePath else {
            return nil
        }
        return NSString(string: pinYinCachePath).appendingPathComponent(key)
    }

    fileprivate static func cache(_ object: Any, forKey key: String) {
        let archivedData = NSKeyedArchiver.archivedData(withRootObject: object)
        guard let cachePath = pinYinCachePath(forKey: key) else {
            return
        }
        DispatchQueue.global(qos: .default).async { 
            do {
                try archivedData.write(to: URL(fileURLWithPath: cachePath), options: .atomicWrite)
            } catch let error {
                print("cache object error: \(error)")
            }
        }
    }

    fileprivate static func cachedObject(forKey key: String) -> Any? {
        guard let cachePath = pinYinCachePath(forKey: key) else {
            return nil
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: cachePath), options: [])
            return NSKeyedUnarchiver.unarchiveObject(with: data)
        } catch _ {
            return nil
        }
    }
}
