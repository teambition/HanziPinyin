//
//  HanziPinyin.swift
//  HanziPinyin
//
//  Created by Xin Hong on 16/4/16.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import Foundation

internal struct HanziCodePoint {
    static let start:UInt32 = 0x4E00
    static let end: UInt32 = 0x9FFF
}

internal struct HanziPinyin {
    internal static let sharedInstance = HanziPinyin()
    internal private(set) var unicodeToPinyinTable: [String: String] = [:]

    init() {
        unicodeToPinyinTable = initializeResource()
    }

    internal static func pinyinArrayWithCharCodePoint(charCodePoint: UInt32, outputFormat: PinyinOutputFormat = PinyinOutputFormat.defaultFormat) -> [String] {
        func isValidPinyin(pinyin: String) -> Bool {
            return pinyin != "(none0)" && pinyin.hasPrefix("(") && pinyin.hasSuffix(")")
        }

        let codePointHex = String(format: "%x", charCodePoint).uppercaseString
        guard let pinyin = HanziPinyin.sharedInstance.unicodeToPinyinTable[codePointHex] where isValidPinyin(pinyin) else {
            return []
        }

        let leftBracketRange = pinyin.rangeOfString("(")!
        let rightBracketRange = pinyin.rangeOfString(")")!
        let processedPinyin = pinyin.substringWithRange(leftBracketRange.endIndex..<rightBracketRange.startIndex)
        let pinyinArray = processedPinyin.componentsSeparatedByString(",")

        let formattedPinyinArray = pinyinArray.map { (pinyin) -> String in
            return PinyinFormatter.formatPinyin(pinyin, withOutputFormat: outputFormat)
        }
        return formattedPinyinArray
    }

    internal static func isHanzi(charCodePoint: UInt32) -> Bool {
        return charCodePoint >= HanziCodePoint.start && charCodePoint <= HanziCodePoint.end
    }
}
