//
//  ScanFoodViewModel.swift
//  spajam-product
//
//  Created by Fumiya Tanaka on 2020/10/10.
//

import Foundation
import RxCocoa
import RxSwift
import Action

final class ScanFoodViewModel {
    
    let scanning: BehaviorRelay<Bool> = .init(value: true)
    let nutritions: BehaviorRelay<[Any]?> = .init(value: nil)
    
    func didTapScanButton() {
        scanning.accept(false)
        nutritions.accept(["Test"])
    }
}
