//
//  String+HanziPinyin.swift
//  HanziPinyin
//
//  Created by Xin Hong on 16/4/16.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import Foundation

public extension String {
    func toPinyin(withFormat outputFormat: PinyinOutputFormat = .default, separator: String = " ") -> String {
        var pinyinStrings = [String]()
        for unicodeScalar in unicodeScalars {
            let charCodePoint = unicodeScalar.value
            let pinyinArray = HanziPinyin.pinyinArray(withCharCodePoint: charCodePoint, outputFormat: outputFormat)

            if pinyinArray.count > 0 {
                pinyinStrings.append(pinyinArray.first! + separator)
            } else {
                pinyinStrings.append(String(unicodeScalar))
            }
        }

        var pinyin = pinyinStrings.joined(separator: "")
        if !pinyin.isEmpty && String(pinyin.suffix(from: pinyin.index(pinyin.endIndex, offsetBy: -1))) == separator {
            pinyin.remove(at: pinyin.index(pinyin.endIndex, offsetBy: -1))
        }

        return pinyin
    }

    func toPinyin(withFormat outputFormat: PinyinOutputFormat = .default, separator: String = " ", completion: @escaping ((_ pinyin: String) -> ())) {
        DispatchQueue.global(qos: .default).async {
            let pinyin = self.toPinyin(withFormat: outputFormat, separator: separator)
            DispatchQueue.main.async {
                completion(pinyin)
            }
        }
    }

    func toPinyinAcronym(withFormat outputFormat: PinyinOutputFormat = .default, separator: String = "") -> String {
        var pinyinStrings = [String]()
        for unicodeScalar in unicodeScalars {
            let charCodePoint = unicodeScalar.value
            let pinyinArray = HanziPinyin.pinyinArray(withCharCodePoint: charCodePoint, outputFormat: outputFormat)

            if pinyinArray.count > 0 {
                let acronym = pinyinArray.first!.first!
                pinyinStrings.append(String(acronym) + separator)
            } else {
                pinyinStrings.append(String(unicodeScalar))
            }
        }

        var pinyinAcronym = pinyinStrings.joined(separator: "")
        if !pinyinAcronym.isEmpty && String(pinyinAcronym.suffix(from: pinyinAcronym.index(pinyinAcronym.endIndex, offsetBy: -1))) == separator {
            pinyinAcronym.remove(at: pinyinAcronym.index(pinyinAcronym.endIndex, offsetBy: -1))
        }

        return pinyinAcronym
    }

    func toPinyinAcronym(withFormat outputFormat: PinyinOutputFormat = .default, separator: String = "", completion: @escaping ((_ pinyinAcronym: String) -> ())) {
        DispatchQueue.global(qos: .default).async {
            let pinyinAcronym = self.toPinyinAcronym(withFormat: outputFormat, separator: separator)
            DispatchQueue.main.async {
                completion(pinyinAcronym)
            }
        }
    }

    var hasChineseCharacter: Bool {
        for unicodeScalar in unicodeScalars {
            let charCodePoint = unicodeScalar.value
            if HanziPinyin.isHanzi(ofCharCodePoint: charCodePoint) {
                return true
            }
        }
        return false
    }
}
