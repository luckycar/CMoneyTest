//
//  FirstViewController.swift
//  CMoneyTest
//
//  Created by KuanHaoChen on 2021/2/12.
//  Copyright © 2021 KuanHaoChen. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func goToSecond(_ sender: Any) {
        let sec = SecondViewController()
        self.navigationController?.pushViewController(sec, animated: true)
    }
    
}
