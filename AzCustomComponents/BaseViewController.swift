//
//  BaseViewController.swift
//  AzCustomComponents
//
//  Created by Sefa Aycicek on 1.03.2024.
//

import UIKit
import NVActivityIndicatorView
import SnapKit

class BaseViewController: UIViewController {
    var activityIndicator : NVActivityIndicatorView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func prepareActivityIndicator() {
        if(activityIndicator == nil) {
            activityIndicator = NVActivityIndicatorView(frame: CGRect.zero,
                                                       type: .ballBeat,
                                                       color: UIColor.red)
           self.view.addSubview(activityIndicator!)
           
           activityIndicator!.snp.makeConstraints { make in
               make.center.equalToSuperview()
               make.height.width.equalTo(50)
           }
        }
        //activityIndicator.stopAnimating()
    }
    
    func startLoading() {
        prepareActivityIndicator()
        activityIndicator?.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator?.stopAnimating()
    }
}
