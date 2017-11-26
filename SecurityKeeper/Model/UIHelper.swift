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
    
    static func throwAn(error message:String){
        guard let top = topVC else{return}
        let label = UILabel(frame: CGRect(x: 0, y: -100, width: top.view.bounds.width, height: 30))
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = message
        label.sizeToFit()
        //label.layer.cornerRadius = label.bounds.height/2
        label.layer.masksToBounds = true
        label.backgroundColor = .cyan
        top.view.addSubview(label)
        
        let group = CAAnimationGroup()
        let opa = CABasicAnimation(keyPath: "opacity")
        opa.fromValue = 0
        opa.toValue = 1
        
        let move = CABasicAnimation(keyPath: "position")
        move.fromValue = NSValue(cgPoint: label.layer.position)
        var p = label.layer.position
        p.y += 120
        move.toValue = p
        
        group.animations = [opa,move]
        group.duration = 1
        group.isRemovedOnCompletion = false
        group.fillMode = kCAFillModeForwards
        label.layer.add(group, forKey: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            label.removeFromSuperview()
        }
    }
}
