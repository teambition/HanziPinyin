//
//  ActivityButton.swift
//  HanziPinyinExample
//
//  Created by Xin Hong on 16/4/16.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit

class ActivityButton: UIButton {
    private lazy var activityIndicator: UIActivityIndicatorView = { [unowned self] in
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .White)
        return activityIndicator
    }()
    private var title: String?

    override func awakeFromNib() {
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        addConstraint(NSLayoutConstraint(item: activityIndicator, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: activityIndicator, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
    }

    override var enabled: Bool {
        didSet {
            if enabled {
                backgroundColor = UIColor(red: 3 / 255, green: 169 / 255, blue: 244 / 255, alpha: 1)
            } else {
                backgroundColor = UIColor(white: 189 / 255, alpha: 1)
            }
        }
    }

    func startAnimating() {
        title = titleLabel?.text
        setTitle(nil, forState: .Normal)
        activityIndicator.startAnimating()
    }

    func stopAnimating() {
        activityIndicator.stopAnimating()
        setTitle(title, forState: .Normal)
    }
}
