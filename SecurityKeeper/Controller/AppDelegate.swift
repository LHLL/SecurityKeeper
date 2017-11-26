//
//  AppDelegate.swift
//  SecurityKeeper
//
//  Created by 李玲 on 11/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private lazy var securityImage:UIView = {
        let imgView = Bundle.main.loadNibNamed("ProtectionView",
                                               owner: nil,
                                               options: nil)?.last as! UIView
        imgView.frame = UIScreen.main.bounds
        return imgView
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let cre = PersistentManager.shared
        cre.selfCheck()
        print(cre.load(entity: "Asset").count)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        if let top = UIHelper.topVC {
            top.view.addSubview(securityImage)
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        securityImage.removeFromSuperview()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

