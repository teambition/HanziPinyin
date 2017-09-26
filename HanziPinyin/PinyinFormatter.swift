//
//  PinyinFormatter.swift
//  HanziPinyin
//
//  Created by Xin Hong on 16/4/16.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import Foundation

internal struct PinyinFormatter {
    internal static func format(_ pinyin: String, withOutputFormat format: PinyinOutputFormat) -> String {
        var formattedPinyin = pinyin

        switch format.toneType {
        case .none:
            formattedPinyin = formattedPinyin.replacingOccurrences(of: "[1-5]", with: "", options: .regularExpression, range: formattedPinyin.startIndex..<formattedPinyin.endIndex)
        case .toneNumber:
            break
        }

        switch format.vCharType {
        case .vCharacter:
            formattedPinyin = formattedPinyin.replacingOccurrences(of: "u:", with: "v")
        case .uUnicode:
            formattedPinyin = formattedPinyin.replacingOccurrences(of: "u:", with: "ü")
        case .uAndColon:
            break
        }

        switch format.caseType {
        case .lowercased:
            formattedPinyin = formattedPinyin.lowercased()
        case .uppercased:
            formattedPinyin = formattedPinyin.uppercased()
        case .capitalized:
            formattedPinyin = formattedPinyin.capitalized
        }

        return formattedPinyin
    }
}
