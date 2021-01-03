//
//  UIImageView.swift
//  Isetan
//
//  Created by Kaung Soe on 5/9/19.
//  Copyright © 2019 codigo. All rights reserved.
//

import UIKit

/* extension UIImageView {
    
//    func setImage(with url: URL) {
//        kf.setImage(with: url, options: [
//                                .transition(ImageTransition.fade(0.3)),
//                                .forceTransition,
//                                .keepCurrentImageWhileLoading
//                            ]
//        )
//    }
    func setImage(fromCache cacheKey: String) {
        ImageCache.default.retrieveImage(forKey: cacheKey, options: nil, callbackQueue: .mainAsync) {
            switch $0 {
            case let .success(v):
                self.image = v.image
                
            case .failure: log.debug($0)
            }
        }
    }
    
    func setImage(with resource: ImageResource,
                  options: [KingfisherOptionsInfoItem] = [.transition(ImageTransition.fade(0.3)),
                                                          .forceTransition,
                                                          .keepCurrentImageWhileLoading ]
        ) {
        kf.setImage(with: resource, options: options)
    }
    
    func setImage(with url: URL,
                  options: [KingfisherOptionsInfoItem] = [.transition(ImageTransition.fade(0.3)),
                                                          .forceTransition,
                                                          .keepCurrentImageWhileLoading ]
        ) {
            kf.setImage(with: url, options: options)
    }
    
    func setImage(with url: URL, completion handler: @escaping (Bool) -> Void) {
        
        kf.setImage(with: url, options: [.transition(ImageTransition.fade(0.3))]) {
            switch $0 {
            case let .success(v):
                self.image = v.image
                handler(true)
                
            case .failure:
                handler(false)
            }
            
        }
    }
    
    func setPaymentLogo(for type: String?) {
        guard let type = type else { return }
        switch type.lowercased() {
        case "amex": image = UIImage(named: "paymentAmex")
        case "mastercard": image =  UIImage(named: "paymentMastercard")
        case "visa": image = UIImage(named: "paymentVisa")
        default: return
        }
    }
    
}
*/

public extension UIImageView {
    func createImageWithLabelOverlay(text: String, isFromCamera: Bool = false) -> UIImage? {
        let imageSize = self.image?.size ?? .zero
        UIGraphicsBeginImageContextWithOptions(CGSize(width: imageSize.width, height: imageSize.height), false, 1.0)
        let currentView = UIView(frame: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        let currentImage = UIImageView(image: self.image)
        currentImage.frame = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
        currentView.addSubview(currentImage)

        let label = UILabel()
        label.frame = currentView.frame

//        for family in UIFont.familyNames {
//             print("family:", family)
//             for font in UIFont.fontNames(forFamilyName: family) {
//                 print("font:", font)
//             }
//         }
        let fontSize: CGFloat = isFromCamera ? 100 : 34
        let font = UIFont(name:"Noteworthy-Light" , size: fontSize)
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: font ?? .init(), range: (text as NSString).range(of: text))
        label.attributedText = attributedStr
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = text
        label.center = currentView.center
        currentView.addSubview(label)

        guard let currentContext = UIGraphicsGetCurrentContext() else {
            return nil
        }
        currentView.layer.render(in: currentContext)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}
