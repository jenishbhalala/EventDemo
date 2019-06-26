//
//  NavigationClass.swift
//  Eventmanage
//
//  Created by Jenish on 25/06/19.
//  Copyright © 2019 Jenish. All rights reserved.
//

import UIKit
import SVProgressHUD

class Navigation{
    
    static func mainStoryboard(storyboard: String) -> UIStoryboard {
        return UIStoryboard(name: storyboard, bundle: nil)
    }
    
    static func instantiateViewController(storyboard: String, withIdentifier: String) -> UIViewController{
        return mainStoryboard(storyboard: storyboard).instantiateViewController(withIdentifier: withIdentifier) as UIViewController
    }
    
    static func rootController(storyboard: String, withIdentifier: String) {
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        let controller = self.instantiateViewController(storyboard: storyboard, withIdentifier: withIdentifier)
        appDelegate.window?.rootViewController = controller
        appDelegate.window?.makeKeyAndVisible()
    }
    
    
    
    static func settingController(storyboard: String, withIdentifier: String) {
        
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        
        let storyboards = UIStoryboard.init(name:storyboard , bundle: nil)
        let viewController = storyboards.instantiateViewController(withIdentifier: withIdentifier) as! UIViewController
        let navigationController = UINavigationController.init(rootViewController: viewController)
        
        appDelegate.window?.rootViewController = navigationController
        appDelegate.window?.makeKeyAndVisible()
    }
 
}
func showProgress(maskType : SVProgressHUDMaskType = .none) {
    SVProgressHUD.show()
    SVProgressHUD.setDefaultStyle(.dark)
    SVProgressHUD.setBackgroundColor(UIColor.clear)
    SVProgressHUD.setDefaultAnimationType(.native)
    SVProgressHUD.setDefaultMaskType(maskType)
}
func hideProgress() {
    DispatchQueue.main.async {
        SVProgressHUD.dismiss()
    }
}
func callNetworkAlert()
{
    let alert = UIAlertController(title: "Bad Internet Connection!", message: "Please check your internet connection.", preferredStyle: UIAlertController.Style.alert)
    let action1 = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { (dd) -> Void in
    }
    alert.addAction(action1)
}



