//
//  AzCustomView.swift
//  AzCustomComponents
//
//  Created by Sefa Aycicek on 1.03.2024.
//

import UIKit

@IBDesignable
class AzCustomView: UIView {

    @IBInspectable
    public var radiusValue : CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = radiusValue
        }
    }
    
    @IBInspectable
    public var borderWidth : CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    public var borderColor : UIColor = UIColor.red {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    public var shadowColor : UIColor = UIColor.red {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable
    public var shadowOpacity : Float = 0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable
    public var shadowOffset : CGSize = CGSize.zero {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
    
    /*@IBInspectable
    public var blackBorderedStyle : Bool = false {
        didSet {
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.borderWidth = 2
        }
    }*/

}

extension UIView {
    func provideAnimation() {
        //transform
        
        self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            //.concatenating(CGAffineTransform(rotationAngle: .pi / 2))
            //.concatenating(CGAffineTransform(translationX: 100, y: -100))
        

        UIView.animate(withDuration: 5.0,
                       delay: 0.0,
                       usingSpringWithDamping: 0.1,
                       initialSpringVelocity: 8) {
            self.transform = CGAffineTransform.identity
        }
        
        /*UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        } completion: { isCompleted in
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform.identity
            }
        }*/

    }
}
