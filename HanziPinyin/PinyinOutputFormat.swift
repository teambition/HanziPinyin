//
//  PinyinOutputFormat.swift
//  HanziPinyin
//
//  Created by Xin Hong on 16/4/16.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import Foundation

public enum PinyinToneType {
    case none
    case toneNumber
}

public enum PinyinVCharType {
    case vCharacter
    case uUnicode
    case uAndColon
}

public enum PinyinCaseType {
    case lowercased
    case uppercased
    case capitalized
}

public struct PinyinOutputFormat {
    public var toneType: PinyinToneType
    public var vCharType: PinyinVCharType
    public var caseType: PinyinCaseType

    public static var `default`: PinyinOutputFormat {
        return PinyinOutputFormat(toneType: .none, vCharType: .vCharacter, caseType: .lowercased)
    }

    public init(toneType: PinyinToneType, vCharType: PinyinVCharType, caseType: PinyinCaseType) {
        self.toneType = toneType
        self.vCharType = vCharType
        self.caseType = caseType
    }
}
