//
//  SwiftViewController.swift
//  BTCoreTestFramework
//
//  Created by 冯才凡 on 2018/8/31.
//  Copyright © 2018年 冯才凡. All rights reserved.
//

import UIKit
import Masonry

@objc open class SwiftViewController: BaseViewController {

    override open func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.yellow
        
        let test = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        test.backgroundColor = UIColor.cyan
        view.addSubview(test)
        
        test.mas_makeConstraints { (make) in
            make?.center.equalTo()(self.view)
        }

    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
