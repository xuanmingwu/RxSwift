//
//  RoundedBorderTextField.swift
//  versi-app
//
//  Created by 吳玹銘 on 2023/12/18.
//

import UIKit

class RoundedBorderTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        let placehold = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Color")!])
        attributedPlaceholder = placehold
        backgroundColor = UIColor.white
        layer.cornerRadius = frame.height / 2
        layer.borderColor = UIColor(named: "Color")?.cgColor
        layer.borderWidth = 3
    }

}
