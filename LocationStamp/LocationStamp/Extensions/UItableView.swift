//
//  UItableView.swift
//  TapRider
//
//  Created by Codigo Phyo Thiha on 4/20/20.
//  Copyright © 2020 42dot. All rights reserved.
//

import Foundation
import UIKit
extension UITableView {
    func register(cell: String) {
        register(UINib(nibName: cell,
                       bundle: nil),
                 forHeaderFooterViewReuseIdentifier: cell)
    }
}
