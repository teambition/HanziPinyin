//
//  HanziPinyin.swift
//  HanziPinyin
//
//  Created by Xin Hong on 16/4/16.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import Foundation

internal struct HanziCodePoint {
    static let start: UInt32 = 0x4E00
    static let end: UInt32 = 0x9FFF
}

internal struct HanziPinyin {
    internal class WhateverClass { }

    internal static let sharedInstance = HanziPinyin()
    internal fileprivate(set) var unicodeToPinyinTable = [String: String]()

    init() {
        unicodeToPinyinTable = initializeResource()
    }

    internal static func pinyinArray(withCharCodePoint charCodePoint: UInt32, outputFormat: PinyinOutputFormat = .default) -> [String] {
        func isValidPinyin(_ pinyin: String) -> Bool {
            return pinyin != "(none0)" && pinyin.hasPrefix("(") && pinyin.hasSuffix(")")
        }

        let codePointHex = String(format: "%x", charCodePoint).uppercased()
        guard let pinyin = HanziPinyin.sharedInstance.unicodeToPinyinTable[codePointHex], isValidPinyin(pinyin) else {
            return []
        }

        let leftBracketRange = pinyin.range(of: "(")!
        let rightBracketRange = pinyin.range(of: ")")!
        let processedPinyin = String(pinyin[leftBracketRange.upperBound..<rightBracketRange.lowerBound])
        let pinyinArray = processedPinyin.components(separatedBy: ",")

        let formattedPinyinArray = pinyinArray.map { (pinyin) -> String in
            return PinyinFormatter.format(pinyin, withOutputFormat: outputFormat)
        }
        return formattedPinyinArray
    }

    internal static func isHanzi(ofCharCodePoint charCodePoint: UInt32) -> Bool {
        return charCodePoint >= HanziCodePoint.start && charCodePoint <= HanziCodePoint.end
    }
}
