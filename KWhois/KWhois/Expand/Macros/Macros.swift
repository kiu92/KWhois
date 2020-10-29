//
//  Macros.swift
//  Xiniuyun
//
//  Created by kiu on 2020/3/9.
//  Copyright © 2020 kiu. All rights reserved.
//

import Foundation

import UIKit

// 宽高度宏定义
let MSWIDTH     = UIScreen.main.bounds.size.width
let MSHEIGHT    = UIScreen.main.bounds.size.height

// 判断是否iPhone
let IS_IPHONE  = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 740, height: 1334).equalTo((UIScreen.main.currentMode?.size)!) : false)
// 判断是否iPhone Plus
let IS_IPHONE_PLUS  = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1242, height: 2208).equalTo((UIScreen.main.currentMode?.size)!) : false)
// 判断是否iPhone X / XS
let IS_IPHONE_X  = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1125, height: 2436).equalTo((UIScreen.main.currentMode?.size)!) : false)
// 判断是否iPhone Xr
let IS_IPHONE_Xr  = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 828, height: 1792).equalTo((UIScreen.main.currentMode?.size)!) : false)
// 判断是否iPhone Xs Max
let IS_IPHONE_Xs_Max  = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1242, height: 2688).equalTo((UIScreen.main.currentMode?.size)!) : false)

let IS_PhoneXAll = (IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs_Max)

// Tabbar height.
let kTabbarHeight:CGFloat                    = (IS_PhoneXAll ? 83 : 49)
// status bar height.
let kStatusBarHeight:CGFloat                 = (IS_PhoneXAll ? 44 : 20)
// Tabbar safe bottom margin.
let kTabbarSafeBottomMargin:CGFloat          = (IS_PhoneXAll ? 34 : 0)
// Status bar & navigation bar height.
let kStatusBarAndNavigationBarHeight:CGFloat = (IS_PhoneXAll ? 88 : 64)

//MARK:- 沙盒
/// document文件夹
let kDocumentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString

/// Library文件夹
let kLlibraryPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first! as String

/// Library--Caches
let kCachesPath   = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first! as String

//MARK:- 版本号、设备号、udid等
/// app名称
let kAppName      = Bundle.main.object(forInfoDictionaryKey:"CFBundleDisplayName")
/// app版本号
let kAppVersion   = Bundle.main.object(forInfoDictionaryKey:"CFBundleShortVersionString")
/// 系统版本号
let kSysVersion   = UIDevice.current.systemVersion
/// udid
let kSysUDID      = UIDevice.current.identifierForVendor!.uuidString
