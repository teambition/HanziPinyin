//
//  HanziPinyinExampleViewController.swift
//  HanziPinyinExample
//
//  Created by Xin Hong on 16/4/16.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit
import HanziPinyin

class HanziPinyinExampleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("我爱中文".toPinyin())
        print("I love Chinese.".toPinyin())
    }
}
