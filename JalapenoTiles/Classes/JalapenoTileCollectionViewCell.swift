//
//  JalapenoTileCollectionViewCell.swift
//  Jalapeno-tiles
//
//  Created by Bartek Pichalski on 19/11/2018.
//  Copyright © 2018 com.pichalski.bartek. All rights reserved.
//

import UIKit

protocol JalapenoContainerDelegate: class {
    func updateBasket(item: JalapenoModel, number: Int)
}

class JalapenoTileCollectionViewCell: UICollectionViewCell {

    enum JalapenoBuyContainer {
        case open, close
    }

    var leftConstraint: NSLayoutConstraint!
    var jalapenoBuyContainer: JalapenoBuyContainer = .close
    var jalapenoPriceLabel: JalapenoPriceLabelView!
    var jalapenoShadowView: ShadowView = ShadowView()
    weak var delegate: JalapenoContainerDelegate?

    var jalapenoModel: JalapenoModel? {
        didSet {
            guard let model = self.jalapenoModel else {
                return
            }
            let price = Int(model.price)
            self.jalapenoTitleLabel.text = model.title
            self.jalapenoImageView.image = UIImage(named: model.imageName)
            self.jalapenoPriceLabel.bigNumberLabel.text = "\(price)"
            self.jalapenoPriceLabel.smallNumberLabel.text = self.getLowerNumber(fullPrice: model.price, price: price)
        }
    }

    var jalapenoNumber: Int = 0 {
        didSet {
            if jalapenoNumber >= 0 {
                self.jalapenoCountNumber.text = "\(self.jalapenoNumber)"
                guard let model = self.jalapenoModel else {
                    return
                }
                self.delegate?.updateBasket(item: model, number: self.jalapenoNumber)
            } else {
                self.jalapenoNumber = 0
                self.animationOut()
            }
        }
    }

    var jalapenoBackgroundView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = UIConstants.JalapenoTileCollectionViewCell.cornerRadius
        return view
    }()

    var jalapenoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    var belowImageView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    var jalapenoTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: ScreenSize.getFontSize())
        label.textAlignment = .center
        return label
    }()

    var jalapenoCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.applySketchShadow(color: UIColor.shadowColor(), alpha: 1, x: 0, y: 2, blur: 4, spread: 0)
        return view
    }()

    var jalapenoRemoveButton: UIButton = {
        let button = UIButton()
        let bundle = Bundle(for: JalapenoTilesView.self)
        let image = UIImage(named: "addShape", in: bundle, compatibleWith: nil)
        button.setImage(image, for: .normal)
        return button
    }()

    var jalapenoAddButton: UIButton = {
        let button = UIButton()
        let bundle = Bundle(for: JalapenoTilesView.self)
        let image = UIImage(named: "addShape", in: bundle, compatibleWith: nil)
        button.setImage(image, for: .normal)
        button.isHidden = true
        return button
    }()

    var jalapenoCountNumber: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = UIFont(name: "AvenirNext-DemiBold",
                            size: UIConstants.JalapenoTileCollectionViewCell.countLabelTextSize)
        label.textAlignment = .center
        label.isHidden = true
        label.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupConstraints()
    }

    func configure(model: JalapenoModel, delegate: JalapenoContainerDelegate, showPriceTag: Bool = true, textColor: UIColor, accentColor: UIColor) {
        self.jalapenoModel = model
        self.jalapenoPriceLabel.isHidden = !showPriceTag
        self.jalapenoTitleLabel.textColor = textColor
        self.jalapenoCountNumber.textColor = accentColor
        self.jalapenoAddButton.tintColor = accentColor
        self.jalapenoRemoveButton.tintColor = accentColor
        self.jalapenoPriceLabel.bigNumberLabel.textColor = accentColor
        self.jalapenoPriceLabel.smallNumberLabel.textColor = accentColor
        self.delegate = delegate
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.jalapenoCircleView.layer.cornerRadius = self.jalapenoCircleView.frame.height / 2
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    fileprivate func setupView() {
        self.addSubview(jalapenoShadowView)
        self.addSubview(jalapenoBackgroundView)
        self.jalapenoBackgroundView.addSubview(jalapenoImageView)
        self.jalapenoBackgroundView.addSubview(belowImageView)
        self.belowImageView.addSubview(jalapenoTitleLabel)

        self.jalapenoPriceLabel = JalapenoPriceLabelView()
        self.jalapenoBackgroundView.addSubview(jalapenoPriceLabel)
        self.jalapenoBackgroundView.addSubview(jalapenoCircleView)
        self.jalapenoBackgroundView.addSubview(self.jalapenoCountNumber)
        self.jalapenoBackgroundView.addSubview(self.jalapenoAddButton)
        self.jalapenoCircleView.addSubview(self.jalapenoRemoveButton)

        jalapenoAddButton.addTarget(forControlEvents: .touchUpInside) { [unowned self] _ in
            self.jalapenoNumber += 1
        }

        jalapenoRemoveButton.addTarget(forControlEvents: .touchUpInside) { [unowned self] _ in
            if self.jalapenoBuyContainer == .close {
                self.animationIn()
                if !(self.jalapenoNumber > 0) {
                    self.jalapenoNumber += 1
                }
            } else {
                self.jalapenoNumber -= 1
            }
        }
    }

    func hideBuyContainer() {
        if self.jalapenoBuyContainer == .close {
            return
        }
        self.animationOut()
    }

    fileprivate func getLowerNumber(fullPrice: Double, price: Int) -> String {
        return Int((fullPrice - Double(price)) * 100) == 0 ? ",00" : ",\(Int((fullPrice - Double(price)) * 100))"
    }

    fileprivate func setupConstraints() {
        let metrics = [
            "horizontalBackgroundPadding": UIConstants.JalapenoTileCollectionViewCell.horizontalPaddingToBackground,
            "horizontalTitlePadding": UIConstants.JalapenoTileCollectionViewCell.horizontalPaddingToTitleLabel,
            "topPaddingToTitleLabel": UIConstants.JalapenoTileCollectionViewCell.topPaddingToTitleLabel,
            "bottomPaddingToTitleLabel": UIConstants.JalapenoTileCollectionViewCell.bottomPaddingToTitleLabel,
            "rightMarginToPriceLabel": UIConstants.JalapenoTileCollectionViewCell.rightMarginToPriceLabel,
            "topMarginToPriceLabel": UIConstants.JalapenoTileCollectionViewCell.topMarginToPriceLabel,
            "priceLabelSize": UIConstants.JalapenoTileCollectionViewCell.priceLabelSize,
            "circleViewSize": UIConstants.JalapenoTileCollectionViewCell.circleViewSize,
            "buttonsSize": UIConstants.JalapenoTileCollectionViewCell.addRemoveButtonSize,
            "rightMarginToButton": UIConstants.JalapenoTileCollectionViewCell.rightMarginToAddButton,
        ]

        self.addConstraintsWithFormat(format: "H:|-horizontalBackgroundPadding-[v0]-horizontalBackgroundPadding-|",
                                      metrics: metrics, views: self.jalapenoBackgroundView)
        self.addConstraintsWithFormat(format: "V:|-horizontalBackgroundPadding-[v0]-horizontalBackgroundPadding-|",
                                      metrics: metrics, views: self.jalapenoBackgroundView)

        self.addConstraintsWithFormat(format: "H:|-horizontalBackgroundPadding-[v0]-horizontalBackgroundPadding-|",
                                      metrics: metrics, views: self.jalapenoShadowView)
        self.addConstraintsWithFormat(format: "V:|-horizontalBackgroundPadding-[v0]-horizontalBackgroundPadding-|",
                                      metrics: metrics, views: self.jalapenoShadowView)

        self.jalapenoBackgroundView.addConstraintsWithFormat(format: "H:|[v0(\(ScreenSize.getCellSizes().0))]|", views: self.jalapenoImageView)
        self.jalapenoBackgroundView.addConstraintsWithFormat(format: "H:|[v0]|", views: self.belowImageView)
        self.jalapenoBackgroundView.addConstraintsWithFormat(format: "V:|[v0(\(ScreenSize.getCellSizes().1))][v1]|", views: self.jalapenoImageView, self.belowImageView)

        self.belowImageView.addConstraintsWithFormat(format: "H:|-horizontalTitlePadding-[v0]-horizontalTitlePadding-|",
                                                     metrics: metrics, views: self.jalapenoTitleLabel)
        self.belowImageView.addConstraintsWithFormat(format: "V:|-topPaddingToTitleLabel-[v0]-bottomPaddingToTitleLabel-|",
                                                     metrics: metrics, views: self.jalapenoTitleLabel)

        self.addConstraintsWithFormat(format: "H:[v0]-rightMarginToPriceLabel-|",
                                      metrics: metrics, views: self.jalapenoPriceLabel)
        self.addConstraintsWithFormat(format: "V:|-topMarginToPriceLabel-[v0(priceLabelSize)]",
                                      metrics: metrics, views: self.jalapenoPriceLabel)

        self.addConstraintsWithFormat(format: "H:|-(>=0)-[v0(circleViewSize)]-(>=0)-|",
                                      metrics: metrics, views: self.jalapenoCircleView)
        self.jalapenoCircleView.centerX(equalTo: self.jalapenoBackgroundView)

        self.addConstraintsWithFormat(format: "V:[v0(circleViewSize)]-(\(ScreenSize.getBottomSize()))-|",
                                      metrics: metrics,  views: self.jalapenoCircleView)

        self.jalapenoBackgroundView.addConstraintsWithFormat(format: "H:|-(>=0)-[v0(buttonsSize)][v1(buttonsSize)]-(>=rightMarginToButton)-|",
                                                              metrics: metrics, views: self.jalapenoRemoveButton, jalapenoAddButton)
        self.jalapenoCircleView.addConstraintsWithFormat(format: "V:[v0(buttonsSize)]",
                                                         metrics: metrics, views: self.jalapenoRemoveButton)
        self.jalapenoRemoveButton.centerX(equalTo: self.jalapenoCircleView)
        self.jalapenoRemoveButton.centerY(equalTo: self.jalapenoCircleView)
        self.jalapenoBackgroundView.addConstraintsWithFormat(format: "V:[v0(buttonsSize)]",
                                                             metrics: metrics, views: self.jalapenoAddButton)
        self.jalapenoAddButton.centerY(equalTo: self.jalapenoCircleView)
        self.jalapenoBackgroundView.addConstraintsWithFormat(format: "H:[v0(buttonsSize)]",
                                                             metrics: metrics, views: self.jalapenoCountNumber)
        self.jalapenoBackgroundView.addConstraintsWithFormat(format: "V:[v0(buttonsSize)]-(\(ScreenSize.getBottomSize()))-|",
                                                             metrics: metrics, views: self.jalapenoCountNumber)
        self.jalapenoCountNumber.centerX(equalTo: self.jalapenoBackgroundView)
    }

    fileprivate func animationOut() {
        let movePosition = self.frame.width / 2
        let halfMovePosition = movePosition / 2
        self.jalapenoAddButton.center.x += halfMovePosition
        self.jalapenoCountNumber.isHidden = true
        self.jalapenoAddButton.isHidden = true
        UIView.transition(with: self.jalapenoRemoveButton,
                          duration: UIConstants.JalapenoTileCollectionViewCell.animationDuration,
                          options: .transitionCrossDissolve , animations: {
                            let bundle = Bundle(for: JalapenoTilesView.self)
                            let image = UIImage(named: "addShape", in: bundle, compatibleWith: nil)
                            self.jalapenoRemoveButton.setImage(image, for: .normal)
        }, completion: nil)
        UIView.animate(withDuration: UIConstants.JalapenoTileCollectionViewCell.animationDuration, animations: {
            self.jalapenoCircleView.frame.size.width -= movePosition
            self.jalapenoCircleView.center.x += halfMovePosition
            self.jalapenoAddButton.center.x -= halfMovePosition
            self.jalapenoRemoveButton.transform = CGAffineTransform(rotationAngle: 0)
            self.jalapenoCountNumber.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        })
        self.jalapenoBuyContainer = .close
    }

    fileprivate func animationIn() {
        let movePosition = self.frame.width / 2
        let halfMovePosition = movePosition / 2
        self.jalapenoAddButton.center.x -= halfMovePosition
        UIView.transition(with: self.jalapenoRemoveButton,
                          duration: UIConstants.JalapenoTileCollectionViewCell.animationDuration,
                          options: .transitionCrossDissolve , animations: {
                            let bundle = Bundle(for: JalapenoTilesView.self)
                            let image = UIImage(named: "removeShape", in: bundle, compatibleWith: nil)
                            self.jalapenoRemoveButton.setImage(image, for: .normal)
        }, completion: nil)
        UIView.animate(withDuration: UIConstants.JalapenoTileCollectionViewCell.animationDuration, animations: {
            self.jalapenoCircleView.frame.size.width += movePosition
            self.jalapenoCircleView.center.x -= halfMovePosition
            self.jalapenoAddButton.center.x += halfMovePosition
            self.jalapenoCountNumber.transform = CGAffineTransform(rotationAngle: 0)
            self.jalapenoRemoveButton.transform = CGAffineTransform(rotationAngle: -.pi )
        })
        self.jalapenoCountNumber.isHidden = false
        self.jalapenoAddButton.isHidden = false
        self.jalapenoBuyContainer = .open
    }
}
