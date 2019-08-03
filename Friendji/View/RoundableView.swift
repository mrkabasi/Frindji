//
//  RoundableView.swift
//  Friendji
//
//  Created by Kasra Abasi on 8/2/19.
//  Copyright © 2019 kasraabasi. All rights reserved.
//

/// This could be done by subclassing and @IBInspectable/@IBDesignable but this is the protocol oriented (POP) approach and add a lot of value for future

import UIKit

protocol RoundableViews: class {
    var cornerRadius: CGFloat { get }
}

extension RoundableViews where Self: UIView {
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
}



class RoundableView: UIView, RoundableViews {
    override func layoutSubviews() {
        super.layoutSubviews()
        cornerRadius = 8.0
    }
}



class RoundableImageView: UIImageView, RoundableViews {
    override func layoutSubviews() {
        super.layoutSubviews()
        cornerRadius = 8.0
    }
}



class RoundableButton: UIButton, RoundableViews {
    override func layoutSubviews() {
        super.layoutSubviews()
        cornerRadius = 8.0
    }
}


class PlayButton: UIButton, RoundableViews {
    override func layoutSubviews() {
        super.layoutSubviews()
        cornerRadius = 50
    }
}


