//
//  Jalapeno.swift
//  Jalapeno-tiles
//
//  Created by Bartek Pichalski on 20/11/2018.
//  Copyright © 2018 com.pichalski.bartek. All rights reserved.
//

import UIKit

public class JalapenoModel {

    public var id: String = ""
    public var title: String = ""
    public var imageName: String = ""
    public var price: Double = 0.0

    public init(id: String, title: String, imageName: String, price: Double) {
        self.id = id
        self.title = title
        self.imageName = imageName
        self.price = price
    }
}
