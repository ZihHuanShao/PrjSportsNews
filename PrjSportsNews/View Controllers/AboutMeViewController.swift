//
//  AboutMeViewController.swift
//  PrjSportsNews_v3
//
//  Created by Fred Shao on 2019/2/19.
//  Copyright © 2019年 FredShao. All rights reserved.
//

import UIKit

class AboutMeViewController: UIViewController {
    @IBOutlet weak var noticeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        noticeLabel.clipsToBounds       = true
        noticeLabel.layer.cornerRadius  = 8
    }
}
