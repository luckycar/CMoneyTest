//
//  ThirdViewController.swift
//  CMoneyTest
//
//  Created by KuanHaoChen on 2021/2/13.
//  Copyright © 2021 KuanHaoChen. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var data: JsonData!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setViewData()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setData(data: JsonData) {
        self.data = data
    }
    
    func setViewData() {
        dateLabel.text = dateConversion(dateString: data.date)
        titleLabel.text = data.title
        copyrightLabel.text = data.copyright
        descriptionLabel.text = data.description
        loadImage(urlString: data.hdurl)
    }
    
    func dateConversion(dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "yyyy MMM. dd"
            return formatter.string(from: date)
        }
        return dateString
    }
    
    func loadImage(urlString: String) {
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
                        DispatchQueue.main.async {
                            self.imageView.image = image
                        }
                    }
                }.resume()
            }
        }
    }

}
