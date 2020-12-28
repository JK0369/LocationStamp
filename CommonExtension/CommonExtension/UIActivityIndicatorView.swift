//
//  UIActivityIndicatorView.swift
//  CommonExtension
//
//  Created by 김종권 on 2020/09/03.
//  Copyright © 2020 42dot. All rights reserved.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
    public func scaleIndicator(factor: CGFloat) {
        transform = CGAffineTransform(scaleX: factor, y: factor)
    }
}
