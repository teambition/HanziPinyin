//
//  PinyinFormatter.swift
//  HanziPinyin
//
//  Created by Xin Hong on 16/4/16.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import Foundation

internal struct PinyinFormatter {
    internal static func formatPinyin(pinyin: String, withOutputFormat format: PinyinOutputFormat) -> String {
        var formattedPinyin = pinyin

        switch format.toneType {
        case .None:
            formattedPinyin = formattedPinyin.stringByReplacingOccurrencesOfString("[1-5]", withString: "", options: .RegularExpressionSearch, range: Range(start: formattedPinyin.startIndex, end: formattedPinyin.endIndex))
        case .ToneNumber:
            break
        }

        switch format.vCharType {
        case .VCharacter:
            formattedPinyin = formattedPinyin.stringByReplacingOccurrencesOfString("u:", withString: "v")
        case .UUnicode:
            formattedPinyin = formattedPinyin.stringByReplacingOccurrencesOfString("u:", withString: "ü")
        case .UAndColon:
            break
        }

        switch format.caseType {
        case .Lowercase:
            formattedPinyin = formattedPinyin.lowercaseString
        case .Uppercase:
            formattedPinyin = formattedPinyin.uppercaseString
        }

        return formattedPinyin
    }
}

