//
//  RoundedBorderButton.swift
//  versi-app
//
//  Created by 吳玹銘 on 2023/12/18.
//

import UIKit

class RoundedBorderButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        layer.cornerRadius = frame.height / 2
        layer.borderWidth = 3
        layer.borderColor = UIColor.white.cgColor
    }

}
