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
                pinyinStrings.append(pinyinArray.first!)
            } else {
                pinyinStrings.append(String(unicodeScalar))
            }
        }

        let pinyin = pinyinStrings.joinWithSeparator(separator)
        return pinyin
    }

    public func toPinyinAcronym() -> String {
        return ""
    }

    public func hasChineseCharacters() -> Bool {
        return true
    }
}
