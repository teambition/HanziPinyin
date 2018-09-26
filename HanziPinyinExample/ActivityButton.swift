//
//  ActivityButton.swift
//  HanziPinyinExample
//
//  Created by Xin Hong on 16/4/16.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit

class ActivityButton: UIButton {
    fileprivate lazy var activityIndicator: UIActivityIndicatorView = { [unowned self] in
        let activityIndicator = UIActivityIndicatorView(style: .white)
        return activityIndicator
    }()
    fileprivate var title: String?

    override func awakeFromNib() {
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        addConstraint(NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }

    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                backgroundColor = UIColor(red: 3 / 255, green: 169 / 255, blue: 244 / 255, alpha: 1)
            } else {
                backgroundColor = UIColor(white: 189 / 255, alpha: 1)
            }
        }
    }

    func startAnimating() {
        title = titleLabel?.text
        setTitle(nil, for: .normal)
        activityIndicator.startAnimating()
    }

    func stopAnimating() {
        activityIndicator.stopAnimating()
        setTitle(title, for: .normal)
    }
}
