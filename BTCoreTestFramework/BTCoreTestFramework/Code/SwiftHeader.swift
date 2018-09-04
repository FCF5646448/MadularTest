//
//  SwiftHeader.swift
//  BTCoreTestFramework
//
//  Created by 冯才凡 on 2018/8/31.
//  Copyright © 2018年 冯才凡. All rights reserved.
//

import Foundation


let ScreenWidth:CGFloat      = UIScreen.main.bounds.size.width
let ScreenHeight:CGFloat     = UIScreen.main.bounds.size.height
let ScreenSize:CGSize        = UIScreen.main.bounds.size
let IS_IPHONE_X_Swift:Bool   = UIScreen.main.currentMode?.size.height == 2436
let kNavBarHeight:CGFloat    = IS_IPHONE_X_Swift ? 88.0 : 64.0
let kTabBarHeight:CGFloat    = IS_IPHONE_X_Swift ? 83.0 : 49.0
let kStatusBarHeight:CGFloat = IS_IPHONE_X_Swift ? 44.0 : 20.0

let kIsIPad:Bool             = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)
//let AppDelegate_swift = UIApplication.shared.delegate as? AppDelegate


//enum BTColor:UInt {
//
//    static let  bt_base:UInt32 = 0x00a0ea
//    //---night
//    static let  bt_3391bc,bt_base_n:UInt32 = 0x3391BC
//    static let  bt_text_title,bt_dark_n,bt_navi_n:UInt32 = 0x333333
//    static let  bt_ffffff,bt_text_title_n:UInt32 = 0xffffff
//    static let  bt_9b9b9b,bt_text_sub,bt_text_sub_n:UInt32 = 0x9B9B9B
//    static let  bt_666666,bt_bg_lightgray,bt_bg_lightgray_n:UInt32 = 0x666666
//    static let  bt_bg_n,bt_4a4a4a,bt_bg_middlegray,bt_bg_middlegray_n:UInt32 = 0x4A4A4A
//    static let  bt_bg:UInt32 = 0xF5F9FA
//
//    //---all
//    static let  bt_333333 = 333333
//    static let  bt_f5f5f5:UInt32 = 0xf5f5f5
//    static let  bt_999999:UInt32 = 0x999999
//    static let  bt_dbdbdb:UInt32 = 0xdbdbdb
//    static let  bt_cccccc:UInt32 = 0xcccccc
//    static let  bt_bcbcbc:UInt32 = 0xbcbcbc
//
//
//    static var bt_white: BTColor {
//        get {
//            return .bt_ffffff
//        }
//    }
//    static var bt_white: BTColor {
//        get {
//            return .bt_ffffff
//        }
//    }
//    static var bt_white: BTColor {
//        get {
//            return .bt_ffffff
//        }
//    }
//    static var bt_white: BTColor {
//        get {
//            return .bt_ffffff
//        }
//    }
//
//}


class BTColor {
    static let  bt_base:UInt32            = 0x00a0ea
    static let  bt_white:UInt32           = 0xffffff
    static let  bt_text_title:UInt32      = 0x333333
    static let  bt_text_sub:UInt32        = 0x9B9B9B
    static let  bt_bg_lightgray:UInt32    = 0x666666
    static let  bt_bg_middlegray:UInt32   = 0x4A4A4A
    static let  bt_bg:UInt32              = 0xF5F9FA
    
    //---night
    static let  bt_base_n:UInt32          = 0x3391BC
    static let  bt_dark_n:UInt32          = 0x333333
    static let  bt_navi_n:UInt32          = 0x333333
    static let  bt_text_title_n:UInt32    = 0xffffff
    static let  bt_text_sub_n:UInt32      = 0x9B9B9B
    static let  bt_bg_lightgray_n:UInt32  = 0x666666
    static let  bt_bg_middlegray_n:UInt32 = 0x4A4A4A
    static let  bt_bg_n:UInt32            = 0x4A4A4A
    
    //---all
    static let  bt_333333:UInt32          = 0x333333
    static let  bt_666666:UInt32          = 0x666666
    static let  bt_3391bc:UInt32          = 0x3391bc
    static let  bt_ffffff:UInt32          = 0xffffff
    static let  bt_f5f5f5:UInt32          = 0xf5f5f5
    static let  bt_4a4a4a:UInt32          = 0x4a4a4a
    static let  bt_9b9b9b:UInt32          = 0x9b9b9b
    static let  bt_999999:UInt32          = 0x999999
    static let  bt_dbdbdb:UInt32          = 0xdbdbdb
    static let  bt_cccccc:UInt32          = 0xcccccc
    static let  bt_bcbcbc:UInt32 = 0xbcbcbc
}


//typedef NS_ENUM(NSInteger,BTColor){
//    //--normal
//    static let  bt_base:UInt32 = 0x00a0ea,
//    static let  bt_white:UInt32 = 0xffffff,
//    static let  bt_text_title:UInt32 = 0x333333,
//    static let  bt_text_sub:UInt32 = 0x9B9B9B,
//    static let  bt_bg_lightgray:UInt32 = 0x666666,
//    static let  bt_bg_middlegray:UInt32 = 0x4A4A4A,
//    static let  bt_bg:UInt32 = 0xF5F9FA,
//
//    //---night
//    static let  bt_base_n:UInt32 = 0x3391BC,
//    static let  bt_dark_n:UInt32 = 0x333333,
//    static let  bt_navi_n:UInt32 = 0x333333,
//    static let  bt_text_title_n:UInt32 = 0xffffff,
//    static let  bt_text_sub_n:UInt32 = 0x9B9B9B,
//    static let  bt_bg_lightgray_n:UInt32 = 0x666666,
//    static let  bt_bg_middlegray_n:UInt32 = 0x4A4A4A,
//    static let  bt_bg_n:UInt32 = 0x4A4A4A,
//
//    //---all
//    static let  bt_333333 = 333333,
//    static let  bt_666666:UInt32 = 0x666666,
//    static let  bt_3391bc:UInt32 = 0x3391bc,
//    static let  bt_ffffff:UInt32 = 0xffffff,
//    static let  bt_f5f5f5:UInt32 = 0xf5f5f5,
//    static let  bt_4a4a4a:UInt32 = 0x4a4a4a,
//    static let  bt_9b9b9b:UInt32 = 0x9b9b9b,
//    static let  bt_999999:UInt32 = 0x999999,
//    static let  bt_dbdbdb:UInt32 = 0xdbdbdb,
//    static let  bt_cccccc:UInt32 = 0xcccccc,
//    static let  bt_bcbcbc:UInt32 = 0xbcbcbc,
//};










func SwiftLog<T>(_ message:T,file:String = #file,funcName:String = #function,lineNum:Int = #line) {
    
    #if DEBUG  // 设置在DEBUG 环境下打印LOG ， DEBUG就是在Build Settings 里面设置的标识。
    
    // 1.获取打印所在的文件
    
    let file = (file as NSString).lastPathComponent
    
    //        //2.获取打印所在的方法
    
    //        let funcName = funcName
    
    //        //3.获取打印所在的行
    
    //        let lineNum = lineNum
    
    print("\(file)(\(lineNum)) - \(message)")
    
    #endif
}
