//
//  UITableView.swift
//  globalore
//
//  Created by KaungSoe on 4/4/18.
//  Copyright © 2018 Codigo. All rights reserved.
//
// swiftlint:disable all


import UIKit

public extension UITableView {
    
    func deque<cell: UITableViewCell>(_ cell: cell.Type) -> cell {
        return dequeueReusableCell(withIdentifier: cell.className) as! cell
    }
    
    func dequeHeaderFooter<T: UITableViewHeaderFooterView>(_ cell: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.className) as! T
    }
    
    func register<cell: UITableViewCell>(_ cell: cell.Type) {
        register(cell, forCellReuseIdentifier: cell.className)
    }
    
    func register(nib nibName: String, bundle: Bundle? = nil) {
        self.register(UINib(nibName: nibName , bundle: bundle), forCellReuseIdentifier: nibName)
    }
    
    func registerHeaderFooter(nib nibName: String, bundle: Bundle? = nil) {
        register(UINib(nibName: nibName , bundle: bundle), forHeaderFooterViewReuseIdentifier: nibName)
    }
    
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ headerFooterView: T.Type) {
        register(headerFooterView.self, forHeaderFooterViewReuseIdentifier: headerFooterView.className)
    }
    
    func register(nibs nibNames: [String], bundle: Bundle? = nil) {
        nibNames.forEach {
            self.register(UINib(nibName: $0 , bundle: bundle), forCellReuseIdentifier: $0)
        }
    }
    
    func register(nibs nibNames: [UITableViewCell], bundle: Bundle? = nil) {
        nibNames.forEach {
            self.register(UINib(nibName: $0.className , bundle: bundle), forCellReuseIdentifier: $0.className)
        }
    }
    
    func layoutHeaderView() {
        
        guard let headerView = self.tableHeaderView else { return }
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        let headerWidth = headerView.bounds.size.width;
        let temporaryWidthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "[headerView(width)]", options: NSLayoutConstraint.FormatOptions(rawValue: UInt(0)), metrics: ["width": headerWidth], views: ["headerView": headerView])
        
        headerView.addConstraints(temporaryWidthConstraints)
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let headerSize = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let height = headerSize.height
        var frame = headerView.frame
        
        frame.size.height = height
        headerView.frame = frame
        
        self.tableHeaderView = headerView
        
        headerView.removeConstraints(temporaryWidthConstraints)
        headerView.translatesAutoresizingMaskIntoConstraints = true
        
    }

    func isLast(for indexPath: IndexPath) -> Bool {

        let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
        let indexOfLastRowInLastSection = numberOfRows(inSection: indexOfLastSection) - 1

        return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
    }

}
