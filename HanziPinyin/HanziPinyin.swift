//
//  HanziPinyin.swift
//  HanziPinyin
//
//  Created by Xin Hong on 16/4/16.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import Foundation

internal struct HanziPinyin {
    internal static func pinyinArrayWithCharCodePoint(charCodePoint: UInt32, outputFormat: PinyinOutputFormat = PinyinOutputFormat.defaultFormat) -> [String] {
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
        let pinyinArray = processedPinyin.componentsSeparatedByString(",")

        let formattedPinyinArray = pinyinArray.map { (pinyin) -> String in
            return PinyinFormatter.formatPinyin(pinyin, withOutputFormat: outputFormat)
        }
        return formattedPinyinArray
    }
}
