//
//  JalapenoPriceLabelView.swift
//  Jalapeno-tiles
//
//  Created by Bartek Pichalski on 19/11/2018.
//  Copyright © 2018 com.pichalski.bartek. All rights reserved.
//

import UIKit

class JalapenoPriceLabelView: UIView {

    var bigNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold",
                            size: UIConstants.JalapenoPriceLabelView.bigNumberFontSize)
        label.textColor = UIColor(red:0.38, green:0.80, blue:0.68, alpha:1.0)
        return label
    }()

    var smallNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold",
                            size: UIConstants.JalapenoPriceLabelView.smallNumberFontSize)
        label.textColor = UIColor(red:0.38, green:0.80, blue:0.68, alpha:1.0)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
        self.smallNumberLabel.sizeToFit()
    }

    fileprivate func setupView() {
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
        self.addSubview(bigNumberLabel)
        self.addSubview(smallNumberLabel)
    }

    fileprivate func setupConstraints() {
        let metrics = [
            "horizontalPadding": UIConstants.JalapenoPriceLabelView.horizontalPadding,
            "topMargin": UIConstants.JalapenoPriceLabelView.topMarginToSmallNumber
            ]

        self.addConstraintsWithFormat(format: "H:|-horizontalPadding-[v0][v1]-horizontalPadding-|",
                                      metrics: metrics, views: self.bigNumberLabel, self.smallNumberLabel)
        self.addConstraintsWithFormat(format: "V:|[v0]|", views: self.bigNumberLabel)
        self.addConstraintsWithFormat(format: "V:|-topMargin-[v0]|",
                                      metrics: metrics, views: self.smallNumberLabel)
    }

}
