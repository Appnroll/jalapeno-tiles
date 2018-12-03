//
//  ScreenSizes.swift
//  Jalapeno-tiles
//
//  Created by Bartek Pichalski on 25/11/2018.
//  Copyright © 2018 com.pichalski.bartek. All rights reserved.
//

import UIKit

class ScreenSize {

    enum ScreenSizes {
        case iPhone5, iPhone8, iPhone8Plus, iPhoneX, iphoneXMax
    }

    static func getScreen() -> ScreenSizes {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                return ScreenSizes.iPhone5
            case 1334:
                return ScreenSizes.iPhone8
            case 2208:
                return ScreenSizes.iPhone8Plus
            case 2436:
                return ScreenSizes.iPhoneX
            case 2688:
                return ScreenSizes.iphoneXMax
            default:
                return ScreenSizes.iPhone8
            }
        }
        return ScreenSizes.iPhone8
    }

    static func getCellSizes() -> (Int,Int) {
        switch ScreenSize.getScreen() {
        case .iPhone5:
            return (135, 119)
        case .iPhone8:
            return (163, 143)
        case .iPhone8Plus, .iphoneXMax:
            return (182, 162)
        default:
            return (163, 143)
        }
    }

    static func getFontSize() -> CGFloat {
        switch ScreenSize.getScreen() {
        case .iPhone5:
            return 12.0
        default:
            return 14.0
        }
    }

    static func getBottomSize() -> CGFloat {
        switch ScreenSize.getScreen() {
        case .iPhone5:
            return 43.0
        default:
            return 45.0
        }
    }
}

