//
//  ViewController.swift
//  JalapenoTiles
//
//  Created by Namedix on 12/03/2018.
//  Copyright (c) 2018 Namedix. All rights reserved.
//

import UIKit
import JalapenoTiles

class ViewController: UIViewController {

    var jalapenioCollectionView: JalapenoTilesView!
    let data = [JalapenoModel(id: "1",title: "First Item", imageName: "Jalapenio", price: 10.99),
                JalapenoModel(id: "2",title: "Second Item", imageName: "BajgelZTwarozkiem", price: 29.99),
                JalapenoModel(id: "3",title: "Third Item", imageName: "GrillowanaPapryka", price: 9.99),
                JalapenoModel(id: "4",title: "Fourth Item", imageName: "Jalapenio", price: 10.0)]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }

    fileprivate func setupView() {
        self.view.backgroundColor = UIColor.white
        self.title = "Jalapeno Tiles"

        self.jalapenioCollectionView = JalapenoTilesView(data: data)
        self.jalapenioCollectionView.showPriceTags = true
        self.jalapenioCollectionView.textColor = UIColor.textColor()
        self.jalapenioCollectionView.accentColor = UIColor.priceTextColor()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Basket", style: .plain, target: self, action: #selector(basketTapped))
        self.view.addSubview(self.jalapenioCollectionView)
        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: self.jalapenioCollectionView)
        self.view.addConstraintsWithFormat(format: "V:|[v0]|", views: self.jalapenioCollectionView)
    }

    @objc func basketTapped() {
        var displayString: String = ""
        for (name, number) in self.jalapenioCollectionView.basket {
            if self.data.contains(where: { model in model.id == name}) {
                displayString = displayString + "\((self.data.filter({ model in model.id == name}).first?.title) ?? ""): \(number)\n"
            }
        }

        let alert = UIAlertController(title: "Basket", message: "Items in Basket:\n \(displayString)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok.", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
