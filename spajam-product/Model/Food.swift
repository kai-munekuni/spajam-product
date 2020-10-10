//
//  Food.swift
//  spajam-product
//
//  Created by 張翔 on 2020/10/10.
//

import Foundation

struct Food: Codable {
    let foodName: String
    let imageUrl: String
    let nutritions: Nutritions
}
