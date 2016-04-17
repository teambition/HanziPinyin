//
//  Character+CodePoint.swift
//  HanziPinyin
//
//  Created by Xin Hong on 16/4/16.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import Foundation

internal extension Character {
    internal var unicodeScalarCodePoint: UInt32 {
        return String(self).unicodeScalars.first!.value
    }
}
