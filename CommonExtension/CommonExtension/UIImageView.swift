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
