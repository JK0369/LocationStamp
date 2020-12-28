//
//  ToastMessageView.swift
//  BaseVC
//
//  Created by 김종권 on 2020/12/19.
//

import Foundation
import UIKit
import CommonExtension

class ToastMessageView: UIView {

    @IBOutlet weak var lblToastMessage: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
    }
}
