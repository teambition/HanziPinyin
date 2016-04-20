//
//  String+HanziPinyin.swift
//  HanziPinyin
//
//  Created by Xin Hong on 16/4/16.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import Foundation

public extension String {
    public func toPinyin(withFormat outputFormat: PinyinOutputFormat = PinyinOutputFormat.defaultFormat, separator: String = " ") -> String {
        var pinyinStrings = [String]()
        for unicodeScalar in unicodeScalars {
            let charCodePoint = unicodeScalar.value
            let pinyinArray = HanziPinyin.pinyinArrayWithCharCodePoint(charCodePoint, outputFormat: outputFormat)

            if pinyinArray.count > 0 {
                pinyinStrings.append(pinyinArray.first! + separator)
            } else {
                pinyinStrings.append(String(unicodeScalar))
            }
        }

        var pinyin = pinyinStrings.joinWithSeparator("")
        if !pinyin.isEmpty && pinyin.substringFromIndex(pinyin.endIndex.advancedBy(-1)) == separator {
            pinyin.removeAtIndex(pinyin.endIndex.advancedBy(-1))
        }

        return pinyin
    }

    public func toPinyin(withFormat outputFormat: PinyinOutputFormat = PinyinOutputFormat.defaultFormat, separator: String = " ", completion:((pinyin: String) -> Void)) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let pinyin = self.toPinyin(withFormat: outputFormat, separator: separator)
            dispatch_async(dispatch_get_main_queue(), {
                completion(pinyin: pinyin)
            })
        }
    }

    public func toPinyinAcronym(withFormat outputFormat: PinyinOutputFormat = PinyinOutputFormat.defaultFormat, separator: String = "") -> String {
        var pinyinStrings = [String]()
        for unicodeScalar in unicodeScalars {
            let charCodePoint = unicodeScalar.value
            let pinyinArray = HanziPinyin.pinyinArrayWithCharCodePoint(charCodePoint, outputFormat: outputFormat)

            if pinyinArray.count > 0 {
                let acronym = pinyinArray.first!.characters.first!
                pinyinStrings.append(String(acronym) + separator)
            } else {
                pinyinStrings.append(String(unicodeScalar))
            }
        }

        var pinyinAcronym = pinyinStrings.joinWithSeparator("")
        if !pinyinAcronym.isEmpty && pinyinAcronym.substringFromIndex(pinyinAcronym.endIndex.advancedBy(-1)) == separator {
            pinyinAcronym.removeAtIndex(pinyinAcronym.endIndex.advancedBy(-1))
        }

        return pinyinAcronym
    }

    public func toPinyinAcronym(withFormat outputFormat: PinyinOutputFormat = PinyinOutputFormat.defaultFormat, separator: String = "", completion:((pinyinAcronym: String) -> Void)) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let pinyinAcronym = self.toPinyinAcronym(withFormat: outputFormat, separator: separator)
            dispatch_async(dispatch_get_main_queue(), {
                completion(pinyinAcronym: pinyinAcronym)
            })
        }
    }

    public func hasChineseCharacter() -> Bool {
        for unicodeScalar in unicodeScalars {
            let charCodePoint = unicodeScalar.value
            if HanziPinyin.isHanzi(charCodePoint) {
                return true
            }
        }
        return false
    }
}
