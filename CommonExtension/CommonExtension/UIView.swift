//
//  UIView.swift
//  ComfortDelGro
//
//  Created by Aung Htoo on 8/25/18.
//  Copyright © 2018 Codigo. All rights reserved.
//
// swiftlint:disable all

import Foundation
import UIKit

public extension UIView {
    
    ////////////////////////////////////////////////
    // MARK: - Utilities
    ////////////////////////////////////////////////
    
    @IBInspectable var viewCornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        } set {
            self.layer.cornerRadius = newValue
        }
    }
    
    // Load Nib with ease
    class func fromNib<T: UIView>(_ view: T.Type) -> T {
        return Bundle.main.loadNibNamed(T.className, owner: nil, options: nil)![0] as! T
    }
    
    func loadViewFromNib(nib: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nib, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func addSubViews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func showView() {
        isHidden = false
    }
    
    func hideView() {
        isHidden = true
    }
    
    func animateBorderColor(from oldColor: UIColor = .clear, to color: UIColor = .clear, withDuration duration: CFTimeInterval = 0.3, lay: CALayer? = nil) {
        let borderColor = CABasicAnimation(keyPath: "borderColor")
        borderColor.fromValue = oldColor.cgColor
        borderColor.toValue = color.cgColor
        borderColor.duration = duration
        if let lay = lay {
            lay.borderWidth = 1
            lay.borderColor = UIColor.red.cgColor
            lay.add(borderColor, forKey: "borderColor")
            lay.borderColor = color.cgColor
            return
        }
        layer.add(borderColor, forKey: "borderColor")
        layer.borderColor = color.cgColor
    }
    
    func mask(with image: String) {
        let imageView = UIImageView(image: UIImage(named: image))
        mask = imageView
    }
    //round specfic corner of view
    func maskByRoundingCorners(_ masks: UIRectCorner, withRadii radii: CGSize = CGSize(width: 10, height: 10)) {
        let rounded = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: masks, cornerRadii: radii)

        let shape = CAShapeLayer()
        shape.path = rounded.cgPath

        self.layer.mask = shape
    }

    func addBorder(toEdges edges: UIRectEdge, color: UIColor, thickness: CGFloat) {
        let yourViewBorder = CAShapeLayer()
        yourViewBorder.strokeColor = UIColor.black.cgColor
        yourViewBorder.lineDashPattern = [2, 2]
        yourViewBorder.frame = self.bounds
        yourViewBorder.fillColor = nil
        let rounded = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10))
        yourViewBorder.path = rounded.cgPath
        self.layer.addSublayer(yourViewBorder)
    }
    
    ////////////////////////////////////////////////
    // MARK: Syntatic Sugar for NSlayoutConstraint
    ////////////////////////////////////////////////
    func fillToSuperview(withPadding padding: UIEdgeInsets) {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor, padding: padding)
    }
    
    func fillToSuperview() {
        fillToSuperview(withPadding: .zero)
    }
    
    func centerInSuperview() {
        anchor(centerX: superview?.centerXAnchor, centerY: superview?.centerYAnchor)
    }
    
    func anchorSize(to view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero, centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func addShadow(with color: UIColor? = UIColor(white: 0, alpha: 0.1), opacity: Float = 1, radius: CGFloat = 3, offset: CGSize = CGSize(width:0, height: 2)) {
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowColor = color?.cgColor
    }
    
    ////////////////////////////////////////////////
    // MARK: Inner Shadow for each specific side
    ////////////////////////////////////////////////
    // different inner shadow styles
    enum InnerShadowSide {
        case all, left, right, top, bottom, topAndLeft, topAndRight, bottomAndLeft, bottomAndRight, exceptLeft, exceptRight, exceptTop, exceptBottom
    }
    
    // define function to add inner shadow
    func addInnerShadow(onSide: InnerShadowSide, shadowColor: UIColor, shadowSize: CGFloat, cornerRadius: CGFloat = 0.0, shadowOpacity: Float) {
        // define and set a shaow layer
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = bounds
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowLayer.shadowOpacity = shadowOpacity
        shadowLayer.shadowRadius = shadowSize
        shadowLayer.fillRule = CAShapeLayerFillRule.evenOdd
        
        // define shadow path
        let shadowPath = CGMutablePath()
        
        // define outer rectangle to restrict drawing area
        let insetRect = bounds.insetBy(dx: -shadowSize * 2.0, dy: -shadowSize * 2.0)
        
        // define inner rectangle for mask
        let innerFrame: CGRect = { () -> CGRect in
            switch onSide {
            case .all:
                return CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height)
            case .left:
                return CGRect(x: 0.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 4.0)
            case .right:
                return CGRect(x: -shadowSize * 2.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 4.0)
            case .top:
                return CGRect(x: -shadowSize * 2.0, y: 0.0, width: frame.size.width + shadowSize * 4.0, height: frame.size.height + shadowSize * 2.0)
            case.bottom:
                return CGRect(x: -shadowSize * 2.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 4.0, height: frame.size.height + shadowSize * 2.0)
            case .topAndLeft:
                return CGRect(x: 0.0, y: 0.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 2.0)
            case .topAndRight:
                return CGRect(x: -shadowSize * 2.0, y: 0.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 2.0)
            case .bottomAndLeft:
                return CGRect(x: 0.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 2.0)
            case .bottomAndRight:
                return CGRect(x: -shadowSize * 2.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 2.0)
            case .exceptLeft:
                return CGRect(x: -shadowSize * 2.0, y: 0.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height)
            case .exceptRight:
                return CGRect(x: 0.0, y: 0.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height)
            case .exceptTop:
                return CGRect(x: 0.0, y: -shadowSize * 2.0, width: frame.size.width, height: frame.size.height + shadowSize * 2.0)
            case .exceptBottom:
                return CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height + shadowSize * 2.0)
            }
        }()
        
        // add outer and inner rectangle to shadow path
        shadowPath.addRect(insetRect)
        shadowPath.addRect(innerFrame)
        
        // set shadow path as show layer's
        shadowLayer.path = shadowPath
        
        // add shadow layer as a sublayer
        layer.addSublayer(shadowLayer)
        
        // hide outside drawing area
        clipsToBounds = true
    }
    
    /**
     change red border color
     */
    func error() {
        self.layer.borderColor = UIColor.red.cgColor
    }
    
    /**
     change green border color
     */
    func valid() {
        self.layer.borderColor = UIColor.green.cgColor
    }
    /**
     screenshot of a view
     */
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    enum Corner {
        case TOP_LEFT
        case TOP_RIGHT
        case BOT_LEFT
        case BOT_RIGHT
    }
    
    func addCornerRadius(corners: [Corner], radius: CGFloat) {
        self.clipsToBounds = true
        if #available(iOS 11.0, *) {
            self.layer.cornerRadius = radius
            var toCorners: CACornerMask = []
            for c in corners {
                if c == .TOP_LEFT {
                    toCorners.update(with: .layerMinXMinYCorner)
                } else if c == .TOP_RIGHT {
                    toCorners.update(with: .layerMaxXMinYCorner)
                } else if c == .BOT_LEFT {
                    toCorners.update(with: .layerMinXMaxYCorner)
                } else if c == .BOT_RIGHT {
                    toCorners.update(with: .layerMaxXMaxYCorner)
                }
            }
            if toCorners.isEmpty { return }
            self.layer.maskedCorners = toCorners
            
        } else {
            var toCorners: UIRectCorner = []
            for c in corners {
                if c == .TOP_LEFT {
                    toCorners.update(with: .topLeft)
                } else if c == .TOP_RIGHT {
                    toCorners.update(with: .topRight)
                } else if c == .BOT_LEFT {
                    toCorners.update(with: .bottomLeft)
                } else if c == .BOT_RIGHT {
                    toCorners.update(with: .bottomRight)
                }
            }
            if toCorners.isEmpty {return}
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: toCorners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }

    // border UI 추가

    func addBottomBorderWithColor(color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 1)
        self.layer.addSublayer(border)
    }

    func addAboveTheBottomBorderWithColor(color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        self.layer.addSublayer(border)
    }

    func transformToImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(.init(width: frame.width, height: frame.height), isOpaque, 0.0)
        defer {
            UIGraphicsEndImageContext()
        }
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            return UIGraphicsGetImageFromCurrentImageContext()
        }
        return nil
    }
}
