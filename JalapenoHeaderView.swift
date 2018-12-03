//
//  JalapenoHeaderView.swift
//  Jalapeno-tiles
//
//  Created by Bartek Pichalski on 20/11/2018.
//  Copyright © 2018 com.pichalski.bartek. All rights reserved.
//

import UIKit

class JalapenoHeaderView: UICollectionReusableView {

    var headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold",
                            size: UIConstants.JalapenoHeaderView.headerFontSize)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupConstraints()
    }

    func configure(title: String, color: UIColor) {
        self.headerLabel.text = title
        self.headerLabel.textColor = color
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    fileprivate func setupView() {
        self.addSubview(headerLabel)
    }

    fileprivate func setupConstraints() {
        let metrics = [
            "leftMargin": UIConstants.JalapenoHeaderView.leftMargin,
            "topMargin": UIConstants.JalapenoHeaderView.topMargin,
            "bottomMargin": UIConstants.JalapenoHeaderView.bottomMargin
        ]

        self.addConstraintsWithFormat(format: "H:|-leftMargin-[v0]-|",
                                      metrics: metrics, views: self.headerLabel)
        self.addConstraintsWithFormat(format: "V:|-topMargin-[v0]-bottomMargin-|",
                                      metrics: metrics, views: self.headerLabel)
    }


}
