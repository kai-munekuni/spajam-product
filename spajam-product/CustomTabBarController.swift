//
//  CustomTabBarController.swift
//  spajam-product
//
//  Created by 中嶋裕也 on 2020/10/10.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController {
    
    var addViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = #colorLiteral(red: 0.5333333333, green: 0.7803921569, blue: 0.3568627451, alpha: 1)
        tabBar.backgroundColor = .white
        tabBar.barTintColor = .white
        
        let controller1 = UIViewController()
        let tabItem1 = UITabBarItem()
        tabItem1.image = #imageLiteral(resourceName: "home_outline.png")
        controller1.tabBarItem = tabItem1
        let nav1 = UINavigationController(rootViewController: controller1)

        let controller2 = UIViewController()
        let tabItem2 = UITabBarItem()
        tabItem2.image = #imageLiteral(resourceName: "calendar.png")
        controller2.tabBarItem = tabItem2
        let nav2 = UINavigationController(rootViewController: controller2)
        
        addViewController = UIViewController()
        addViewController?.view.backgroundColor = .white
        
        viewControllers = [nav1, nav2]
        setupMiddleButton()
    }
    
    func setupMiddleButton() {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 50
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame

        menuButton.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.7803921569, blue: 0.3568627451, alpha: 1)
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        let image = #imageLiteral(resourceName: "plus.png")
        menuButton.setImage(image, for: .normal)
        
        view.addSubview(menuButton)

        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)

        view.layoutIfNeeded()
    }


    // MARK: - Actions

    @objc private func menuButtonAction(sender: UIButton) {
        if let vc = addViewController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }

}
