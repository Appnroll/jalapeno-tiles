//
//  UIConstants.swift
//  Jalapeno-tiles
//
//  Created by Bartek Pichalski on 03/12/2018.
//  Copyright © 2018 com.pichalski.bartek. All rights reserved.
//

import UIKit

// swiftlint:disable:next type_body_length
struct UIConstants {
    struct JalapenoTilesView {
        static let horizontalPadding: CGFloat = 7.5 // Left and right padding to collectionView
        static let sectionInset: CGFloat = 6.0 // The left, right, bottom, top section inset in collectionView
    }
    struct JalapenoTileCollectionViewCell {
        static let cornerRadius: CGFloat = 8.0 // Corner radius of view
        static let countLabelTextSize: CGFloat = 24.0 //The size of text in countLabel
        static let horizontalPaddingToBackground: CGFloat = 3.0 // The left and right padding to background view
        static let horizontalPaddingToTitleLabel: CGFloat = 5.0 // The horizontal padding to title label
        static let topPaddingToTitleLabel: CGFloat = 30.0 // The top padding to title label
        static let bottomPaddingToTitleLabel: CGFloat = 16.0 // The bottom padding to title label
        static let rightMarginToPriceLabel: CGFloat = 6.0 // The right constraint to price label
        static let topMarginToPriceLabel: CGFloat = 6.0 // The top constraint to price label
        static let priceLabelSize: CGFloat = 30.0 // Size of price label
        static let circleViewSize: CGFloat = 41.0 // Size of circle View
        static let addRemoveButtonSize: CGFloat =  41.0 // Size of buttons (remove, add)
        static let rightMarginToAddButton: CGFloat = 12.0 // The right margin to add Button
        static let animationDuration: Double = 0.3 // Time of animation
    }
    struct JalapenoPriceLabelView {
        static let bigNumberFontSize: CGFloat = 24.0 // The font size of big number
        static let smallNumberFontSize: CGFloat = 10.0 // The font size of small number
        static let horizontalPadding: CGFloat = 12.0 // The horizontal padding to numbers
        static let topMarginToSmallNumber: CGFloat = 2.0 // The top margin to small number
    }
    struct JalapenoHeaderView {
        static let headerFontSize: CGFloat = 36.0 // The header label font size
        static let leftMargin: CGFloat = 14.0 // The left margin to header label
        static let topMargin: CGFloat = 20.0 // The top margin to header label
        static let bottomMargin: CGFloat = 5.0 // The bottom margin to header label
    }
}
