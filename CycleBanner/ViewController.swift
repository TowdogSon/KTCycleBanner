//
//  ViewController.swift
//  CycleBanner
//
//  Created by tuikai on 2017/7/24.
//  Copyright © 2017年 tuikai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
       setUpUI()
        
    }


}

extension ViewController{
    
    func setUpUI() -> Void {

        let rect = CGRect(x: 0, y: 0, width: kScreenW, height: 200)
        let bannerView = KTBanner(frame: rect, imageNames: ["hulu","life"], timeInterVal: 3)
        view.addSubview(bannerView)
 
    }
}
