//
//  UIView+ConstraintsWithFormat.swift
//  Jalapeno-tiles
//
//  Created by Bartek Pichalski on 20/11/2018.
//  Copyright © 2018 com.pichalski.bartek. All rights reserved.
//

import UIKit

extension UIView {

    @discardableResult
    public func addConstraintsWithFormat(format: String,
                                  identifier: String? = "",
                                  metrics: [String: Any]? = nil,
                                  views: [UIView]) -> [NSLayoutConstraint] {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        let constraints = NSLayoutConstraint.constraints(withVisualFormat: format,
                                                         options: NSLayoutConstraint.FormatOptions(),
                                                         metrics: metrics,
                                                         views: viewsDictionary)

        #if DEBUG
            // Set additional identifier if provided
            if let identifier = identifier {
                for constraint in constraints {
                    constraint.identifier = "$\(identifier)$"
                }
            }
        #endif

        addConstraints(constraints)
        return constraints
    }

    @discardableResult
    public func addConstraintsWithFormat(format: String,
                                  identifier: String? = "",
                                  metrics: [String: Any]? = nil,
                                  views: UIView...) -> [NSLayoutConstraint] {
        return addConstraintsWithFormat(format: format,
                                        identifier: identifier,
                                        metrics: metrics,
                                        views: views)
    }
}
