//
//  UIImageViewExtension.swift
//  GitRepo
//
//  Created by Admin on 11.11.2020.
//

import UIKit

extension UIImageView {
    func loadImageBy(_ string: String?) {
        guard let stringURL = string, let url = URL(string: stringURL) else {
            self.image = UIImage(named: "testFileImage")
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let urlContents = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let imageData = urlContents, let image = UIImage(data: imageData) {
                    self.image = image
                }
            }
        }
    }
}
