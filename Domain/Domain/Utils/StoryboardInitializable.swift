//
//  StoryboardInitializable.swift
//  Domain
//
//  Created by 김종권 on 2020/12/27.
//

import Foundation
import UIKit

public protocol StoryboardInitializable {
    associatedtype ViewModel
    static var storyboardName: String { get set }
    static var storyboardID: String { get set }
    static func instantiate(viewModel: ViewModel) -> Self
    var viewModel: ViewModel! {get set}
    init?(coder: NSCoder, viewModel: ViewModel)
}

public extension StoryboardInitializable where Self: UIViewController {

    static func instantiate(viewModel: ViewModel) -> Self {
        if #available(iOS 13.0, *) {
            let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
            return storyboard.instantiateViewController(identifier: storyboardID) { (coder) -> Self? in
                return Self(coder: coder, viewModel: viewModel)
            }
        } else {
            let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
            var vc = storyboard.instantiateViewController(withIdentifier: storyboardID) as! Self
            vc.viewModel = viewModel
            return vc
        }
    }
}
