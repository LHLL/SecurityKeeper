//
//  UIHelper.swift
//  SecurityKeeper
//
//  Created by 李玲 on 11/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

struct UIHelper {
    static var topVC:UIViewController? {
        guard let key = UIApplication.shared.keyWindow else{return nil}
        guard let root = key.rootViewController else{return nil}
        if root is UINavigationController {
           return (root as! UINavigationController).topViewController
        }else if root is UITabBarController {
            return (root as! UITabBarController).selectedViewController
        }else{
            return root
        }
    }
    
    private init(){}
}
