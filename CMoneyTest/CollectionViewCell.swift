//
//  CollectionViewCell.swift
//  CMoneyTest
//
//  Created by KuanHaoChen on 2021/2/12.
//  Copyright © 2021 KuanHaoChen. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    private var imageUrl = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadImage(urlString: String) {
        imageUrl = urlString
        if let url = URL(string: urlString) {
            let tempDirectory = FileManager.default.temporaryDirectory
            let imageFileUrl = tempDirectory.appendingPathComponent(url.lastPathComponent)
            if FileManager.default.fileExists(atPath: imageFileUrl.path) {
                imageView.image = UIImage(contentsOfFile: imageFileUrl.path)
            } else {
                imageView.image = nil
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let imageData = data, let image = UIImage(data: imageData) {
                        try? imageData.write(to: imageFileUrl)
                        if response?.url?.absoluteString == self.imageUrl {
                            DispatchQueue.main.async {
                                self.imageView.image = image
                            }
                        }
                    }
                }.resume()
            }
        }
    }

}
