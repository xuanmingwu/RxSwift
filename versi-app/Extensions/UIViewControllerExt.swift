//
//  UIViewControllerExt.swift
//  versi-app
//
//  Created by 吳玹銘 on 2023/12/18.
//

import Foundation
import UIKit
import SafariServices

extension UIViewController {

    func presentSFSafariVCFor(url: String) {
        let readmeUrl = URL(string: url + readmeSegment)
        let safariVC = SFSafariViewController(url: readmeUrl!)
        present(safariVC, animated: true)
    }
}
