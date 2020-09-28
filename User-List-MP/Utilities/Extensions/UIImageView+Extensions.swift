//
//  UIImageView+Extensions.swift
//  Users-Miho
//
//  Created by Mac on 9/9/20.
//  Copyright © 2020 Miho. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloadImage(_ urlString: String, _ placeholder: UIImage?, _ completion: (()->Void)?) {
        let imageCache = NSCache<NSString, UIImage>()
        self.image = placeholder
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            completion?()
        } else {
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                self.image = placeholder
                completion?()
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                DispatchQueue.main.async { // Make sure you're on the main thread here
                    if let data = data,
                        let image = UIImage(data: data) {
                        self.image = image
                        imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    } else {
                        self.image = placeholder
                    }
                    completion?()
                }
            }
            task.resume()
        }
    }
    
    func invertColor() {
        guard let image = self.image else { return }
        let ciImage = CIImage(image: image)
        if let filter = CIFilter(name: "CIColorInvert") {
            filter.setValue(ciImage, forKey: kCIInputImageKey)
            let newImage = UIImage(ciImage: filter.outputImage!)
            self.image = newImage
        }
    }
}
