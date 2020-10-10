//
//  TotalNutritionViewController.swift
//  spajam-product
//
//  Created by 中嶋裕也 on 2020/10/10.
//

import Foundation
import UIKit

class TotalNutritionViewController: ViewController {
    override func viewDidLoad() {
        if let nv = navigationController {
            nv.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = .always
            self.navigationItem.title = "1週間栄養トータル"
        }
    }
}
