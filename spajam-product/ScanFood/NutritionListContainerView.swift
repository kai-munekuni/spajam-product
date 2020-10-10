//
//  NutritionListContainerView.swift
//  spajam-product
//
//  Created by Fumiya Tanaka on 2020/10/10.
//

import Foundation
import UIKit

final class NutritionListContainerView: XibView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.masksToBounds = true
    }
    
    func refreshData(data: [Any]) {
        fatalError("not implmented")
    }
}
