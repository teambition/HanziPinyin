//
//  PinyinOutputFormat.swift
//  HanziPinyin
//
//  Created by Xin Hong on 16/4/16.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import Foundation

public enum PinyinToneType {
    case None
    case ToneMark
    case ToneNumber
}

public enum PinyinCaseType {
    case Lowercase
    case Uppercase
}

public enum PinyinVCharType {
    case UAndColon
    case VChar
    case UUnicode
}

public struct PinyinOutputFormat {
    public var toneType: PinyinToneType
    public var caseType: PinyinCaseType
    public var vCharType: PinyinVCharType

    public var defaultFormat: PinyinOutputFormat {
        return PinyinOutputFormat(toneType: .None, caseType: .Lowercase, vCharType: .VChar)
    }
}
