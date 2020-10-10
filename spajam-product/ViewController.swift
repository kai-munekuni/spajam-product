//
//  ViewController.swift
//  spajam-product
//
//  Created by 張翔 on 2020/10/09.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    let action = GetNutritionFromImageAction.action()
    
    init() {
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        action.execute(#imageLiteral(resourceName: "710189.jpeg"))
      

            

      
    }

}
