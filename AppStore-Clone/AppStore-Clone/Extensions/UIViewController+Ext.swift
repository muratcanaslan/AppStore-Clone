//
//  UIViewController+Ext.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 4.02.2023.
//

import UIKit

extension UIViewController {
    func startLoading() {
        DispatchQueue.main.async {
            HudManager.show()
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            HudManager.dismiss()
        }
    }
}
