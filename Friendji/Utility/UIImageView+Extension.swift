//
//  UIImageView+Extension.swift
//  Friendji
//
//  Created by Kasra Abasi on 8/4/19.
//  Copyright © 2019 kasraabasi. All rights reserved.
//

import UIKit

private let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func downloadImageUsingCache(url: URL) {
        self.image = nil
        if let cachedImage = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = cachedImage.withRenderingMode(.automatic)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            if let imageData = data {
                DispatchQueue.main.async {
                    if let downloadedImage = UIImage(data: imageData) {
                        imageCache.setObject(downloadedImage, forKey: url as AnyObject)
                        self.image = downloadedImage.withRenderingMode(.automatic)
                    }
                }
            }
            }.resume()
    }
    
}
