//
//  AppDelegate.swift
//  KWhois
//
//  Created by kiu on 2020/7/21.
//  Copyright © 2020 kiu. All rights reserved.
//

import UIKit

import SnapKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        initIQKeyboardManager()
        sleep(2)

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    //MARK:- 初始化键盘
    func initIQKeyboardManager() {

        // 控制整个功能是否启用。
        IQKeyboardManager.shared.enable = true
        // 控制是否显示键盘上的工具条
        IQKeyboardManager.shared.enableAutoToolbar = true
        // 控制点击背景是否收起键盘
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        // 控制键盘上的工具条文字颜色是否用户自定义
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        // 将右边Done改成完成
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "完成"
        // 最新版的设置键盘的returnKey的关键字 ,可以点击键盘上的next键，自动跳转到下一个输入框，最后一个输入框点击完成，自动收起键盘
        IQKeyboardManager.shared.toolbarManageBehaviour = .byPosition

    }

}

