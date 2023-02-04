//
//  UIApplication+Ext.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 4.02.2023.
//

import UIKit

extension UIApplication {

    var currentKeyWindow: UIWindow? {
        connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .first(where: { $0.isKeyWindow })
    }

    var rootViewController: UIViewController? {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? UIWindowSceneDelegate {
            return sceneDelegate.window??.rootViewController
        }
        return nil
    }

    var presentedController: UIViewController? {
        var controller = rootViewController
        if let presented = controller?.presentedViewController {
            controller = presented
        }
        return controller
    }

}

public extension UIApplication {
    func currentUIWindow() -> UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter({
                $0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})

        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }

        return window

    }
}
