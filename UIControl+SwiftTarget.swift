//
//  UIControl+SwiftTarget.swift
//  Jalapeno-tiles
//
//  This extension allows easier, Swift style assignment of targets and selectors
//  for UIButtons. ✨
//  See http://swiftpearls.com/selectors-with-pure-swift.html
//
//  Created by Bartek Pichalski on 25/11/2018.
//  Copyright © 2018 com.pichalski.bartek. All rights reserved.
//

import UIKit

class ClosureSelector<Parameter> {
    public let selector: Selector
    private let closure: (Parameter) -> Void

    init(withClosure closure: @escaping (Parameter) -> Void) {
        selector = #selector(ClosureSelector.target(param:))
        self.closure = closure
    }

    // Unfortunately we need to cast to Parameter here
    @objc func target(param: AnyObject) {
        guard let param = param as? Parameter else { return }
        closure(param)
    }
}

var handle = 0

extension UIControl {
    func addTarget(forControlEvents controlEvents: UIControl.Event,
                   withClosure closure: @escaping (UIView) -> Void) {
        let closureSelector = ClosureSelector<UIView>(withClosure: closure)
        objc_setAssociatedObject(self,
                                 &handle,
                                 closureSelector,
                                 objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        addTarget(closureSelector, action: closureSelector.selector, for: controlEvents)
    }
}
