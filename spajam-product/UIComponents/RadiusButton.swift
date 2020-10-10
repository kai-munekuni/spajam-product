import Foundation
import UIKit

@IBDesignable
class RadiusButton: UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    init(frame: CGRect, borderWidth: CGFloat, borderColor: UIColor = .systemGray, buttonTitle: String?, buttonImage: UIImage?) {
        super.init(frame: frame)
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.borderColor = UIColor.systemGray.cgColor
    }
    
}
