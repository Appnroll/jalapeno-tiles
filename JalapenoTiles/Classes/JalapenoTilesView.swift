//
//  JalapenoTilesView.swift
//  Jalapeno-tiles
//
//  Created by Bartek Pichalski on 19/11/2018.
//  Copyright © 2018 com.pichalski.bartek. All rights reserved.
//

import UIKit

public class JalapenoTilesView: UIView {

    public var collectionView: UICollectionView!
    private var cellReuseIdentifier: String = "Cell"
    public var showPriceTags: Bool = true
    public var textColor: UIColor = UIColor.textColor()
    public var accentColor: UIColor = UIColor.priceTextColor()
    public var basket: [String : Int] = [:]
    public var data: [JalapenoModel] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupConstraints()
    }

    public convenience init(data: [JalapenoModel]) {
        self.init()
        self.data = data
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    fileprivate func setupView() {
        self.setupCollectionView()
        self.backgroundColor = UIColor.backgroundColor()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissBuyContainer))
        self.collectionView.addGestureRecognizer(tap)
    }

    @objc func dismissBuyContainer() {
        _ = self.collectionView.visibleCells.map { cell in
            guard let jalapenoCell = cell as? JalapenoTileCollectionViewCell else {
                return
            }

            jalapenoCell.hideBuyContainer()
        }
    }

    fileprivate func setupConstraints() {
        let metrics = [
            "horizontalPadding": UIConstants.JalapenoTilesView.horizontalPadding
            ]

        self.addConstraintsWithFormat(format: "H:|-horizontalPadding-[v0]-horizontalPadding-|",
                                      metrics: metrics, views: self.collectionView)
        self.addConstraintsWithFormat(format: "V:|[v0]|", views: self.collectionView)
    }

    fileprivate func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: 1, height: 1)
        layout.sectionInset = UIEdgeInsets(top: UIConstants.JalapenoTilesView.sectionInset,
                                           left: UIConstants.JalapenoTilesView.sectionInset,
                                           bottom: UIConstants.JalapenoTilesView.sectionInset,
                                           right: UIConstants.JalapenoTilesView.sectionInset)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.backgroundColor()
        collectionView.register(JalapenoTileCollectionViewCell.self,
                                forCellWithReuseIdentifier: self.cellReuseIdentifier)
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        self.addSubview(collectionView)
    }

}

extension JalapenoTilesView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellReuseIdentifier, for: indexPath) as? JalapenoTileCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.configure(model: data[indexPath.item], delegate: self,
                       showPriceTag: self.showPriceTags, textColor: self.textColor,
                       accentColor: self.accentColor)
        return cell
    }
}

extension JalapenoTilesView: JalapenoContainerDelegate {
    func updateBasket(item: JalapenoModel, number: Int) {
        basket[item.id] = number

        if number == 0 {
            guard let index = basket.index(forKey: item.id) else {
                return
            }
            basket.remove(at: index)
        }
    }
}
