//
//  UIView+Center.swift
//  Jalapeno-tiles
//
//  Created by Bartek Pichalski on 20/11/2018.
//  Copyright © 2018 com.pichalski.bartek. All rights reserved.
//

import UIKit

extension UIView {
    /// Add constraints to align Y anchor to a specific view.
    /// - parameter alignmentView: The view to align with.
    func centerY(equalTo alignmentView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: alignmentView.centerYAnchor).isActive = true
    }

    /// Add constraints to align X anchor to a specific view.
    /// - parameter alignmentView: The view to align with.
    func centerX(equalTo alignmentView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: alignmentView.centerXAnchor).isActive = true
    }
}

extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
