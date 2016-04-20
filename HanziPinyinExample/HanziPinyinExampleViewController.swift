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
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var pinyinButton: ActivityButton!

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    // MARK: - Helper
    private func setupUI() {
        navigationItem.title = "HanziPinyin"
        inputTextField.returnKeyType = .Done
        inputTextField.placeholder = "Chinese characters..."
        outputTextView.text = nil
        inputTextField.delegate = self
        pinyinButton.enabled = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(inputTextFieldTextChanged(_:)), name: UITextFieldTextDidChangeNotification, object: inputTextField)
    }

    // MARK: - Actions
    @IBAction func pinyinButtonTapped(sender: UIButton) {
        guard let text = inputTextField.text else {
            return
        }

        inputTextField.resignFirstResponder()
        let startTime = NSDate().timeIntervalSince1970
        pinyinButton.startAnimating()
        text.toPinyin { (pinyin) in
            self.pinyinButton.stopAnimating()
            let endTime = NSDate().timeIntervalSince1970
            let totalTime = endTime - startTime
            self.outputTextView.text = "Total Time:" + "\n" + "\(totalTime) (s)" + "\n\n" + "Pinyin:" + "\n" + pinyin
        }
    }

    @IBAction func backgroundTapped(sender: UIControl) {
        UIApplication.sharedApplication().sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, forEvent: nil)
    }

    func inputTextFieldTextChanged(notification: NSNotification) {
        pinyinButton.enabled = inputTextField.text?.characters.count > 0
    }
}

extension HanziPinyinExampleViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        inputTextField.resignFirstResponder()
        return true
    }
}
