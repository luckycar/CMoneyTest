//
//  SecondViewController.swift
//  CMoneyTest
//
//  Created by KuanHaoChen on 2021/2/12.
//  Copyright © 2021 KuanHaoChen. All rights reserved.
//

import UIKit

struct JsonData: Codable {
    let description: String
    let copyright: String
    let title: String
    let url: String
    let apod_site: String
    let date: String
    let media_type: String
    let hdurl: String
}

class SecondViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let fullScreenSize = UIScreen.main.bounds.size
    
    let urlString = "https://raw.githubusercontent.com/cmmobile/NasaDataSet/main/apod.json"
    var collectionDatas: [JsonData] = []
    
    let activity = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let cellWidth = (fullScreenSize.width - 30) / 4
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        activity.center = collectionView.center
        activity.hidesWhenStopped = true
        self.view.addSubview(activity)
        
        getData()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getData() {
        activity.startAnimating()
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                let decoder = JSONDecoder()
                if let data = data {
                    do {
                        self.collectionDatas = try decoder.decode([JsonData].self, from: data)
                        DispatchQueue.main.async {
                            self.activity.stopAnimating()
                            self.collectionView.reloadData()
                        }
                    } catch {
                        
                    }
                }
            }.resume()
        }
    }

}

extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        }
        let data = collectionDatas[indexPath.row]
        cell.label.text = data.title
        cell.loadImage(urlString: data.url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = collectionDatas[indexPath.row]
        let vc = ThirdViewController()
        vc.setData(data: data)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
