//
//  ShadowView.swift
//  Jalapeno-tiles
//
//  Created by Bartek Pichalski on 20/11/2018.
//  Copyright © 2018 com.pichalski.bartek. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }

    private func setupShadow() {
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.1
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds,
                                             byRoundingCorners: .allCorners,
                                             cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
