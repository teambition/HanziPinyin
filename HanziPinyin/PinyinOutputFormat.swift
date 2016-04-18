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
    case ToneNumber
}

public enum PinyinVCharType {
    case VCharacter
    case UUnicode
    case UAndColon
}

public enum PinyinCaseType {
    case Lowercase
    case Uppercase
}

public struct PinyinOutputFormat {
    public var toneType: PinyinToneType
    public var vCharType: PinyinVCharType
    public var caseType: PinyinCaseType

    public static var defaultFormat: PinyinOutputFormat {
        return PinyinOutputFormat(toneType: .None, vCharType: .VCharacter, caseType: .Lowercase)
    }
}
