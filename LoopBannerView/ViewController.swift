//
//  ViewController.swift
//  LoopBannerView
//
//  Created by Pro on 2016/12/17.
//  Copyright © 2016年 LittleMatt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let headView = LoopBannerView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200)) as  LoopBannerView
        self.view.addSubview(headView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

