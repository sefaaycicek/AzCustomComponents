//
//  ViewController.swift
//  AzCustomComponents
//
//  Created by Sefa Aycicek on 1.03.2024.
//

import UIKit
import NVActivityIndicatorView
import SnapKit

class ViewController: BaseViewController {
    @IBOutlet weak var textInput: MaterialBorderedTextField!
    @IBOutlet weak var customView: AzCustomView!
        
    //Gestures
    var tapGesture : UITapGestureRecognizer? = nil // 5 parmakla 3 kere tıkla
    var swipeGesture : UISwipeGestureRecognizer? = nil // sağa sola aşağı yukarı kaydırma
    var panGesture : UIPanGestureRecognizer? = nil // ekranda parmağı gizder.
    var longGesture : UILongPressGestureRecognizer? = nil // örn. 2 sn tıkalyınca bi aksiyon
    var pinchGesture : UIPinchGestureRecognizer? = nil // 2 parmakla resim büyütmedeki aksiyon.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textInput.customDelegate = self
        textInput.onSearchClick = {
            print("button click")
        }
        
        registerGesture()
    }
    
    
    func registerGesture() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture?.numberOfTouchesRequired = 2
        tapGesture?.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(tapGesture!)
        
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeGesture?.direction = .right
        self.view.addGestureRecognizer(swipeGesture!)
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        //self.view.addGestureRecognizer(panGesture!)
        
        longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLong))
        longGesture?.minimumPressDuration = 3
        self.view.addGestureRecognizer(longGesture!)
        
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        self.view.addGestureRecognizer(pinchGesture!)
    }
    
    @objc func handleTap() {
        customView.provideAnimation()
        
    }
    
    @objc func handleSwipe() {
        startLoading()
    }
    
    @objc func handlePan(_ gesture : UIPanGestureRecognizer) {
        let transation = gesture.translation(in: view)
        customView.transform = CGAffineTransform(translationX: transation.x, y: transation.y)
        
    }
    
    @objc func handleLong() {
        hideLoading()
    }
    
    @objc func handlePinch(_ gesture : UIPinchGestureRecognizer) {
        let scale = gesture.scale
        customView.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    
    
    func alternativeClick() {
        print("button click")
    }
}

extension ViewController : CustomButtonInteractionProtocol {
    
}


extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}


extension ViewController : UITableViewDelegate {
    
}
