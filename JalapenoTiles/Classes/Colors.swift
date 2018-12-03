//
//  Colors.swift
//  Jalapeno-tiles
//
//  Created by Bartek Pichalski on 19/11/2018.
//  Copyright © 2018 com.pichalski.bartek. All rights reserved.
//

import UIKit

extension UIColor {

    public class func textColor() -> UIColor {
        return UIColor(red:0.34, green:0.33, blue:0.43, alpha:1.0)
    }

    public class func backgroundColor() -> UIColor {
        return UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
    }

    public class func priceTextColor() -> UIColor {
        return UIColor(red:0.38, green:0.80, blue:0.68, alpha:1.0)
    }

    public class func shadowColor() -> UIColor {
        return UIColor(red:0.61, green:0.61, blue:0.61, alpha:0.3)
    }
}
