//
//  ViewController.swift
//  spajam-product
//
//  Created by 張翔 on 2020/10/09.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    override func loadView() {
        guard let view = UINib(nibName: Self.className, bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        self.view = view
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
      

            

      
    }

}
