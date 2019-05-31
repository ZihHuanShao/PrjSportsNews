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
    @IBOutlet weak var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noticeLabel.clipsToBounds       = true
        noticeLabel.layer.cornerRadius  = 8
        
        tuneLineSpacing(10, contentLabel)
    }
    
    private func tuneLineSpacing(_ space: CGFloat, _ uiLabel: UILabel) {
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = space
        
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15),
                          NSAttributedString.Key.paragraphStyle: paraph]
        contentLabel.attributedText = NSAttributedString(string: uiLabel.text!, attributes: attributes)
        self.view.addSubview(uiLabel)
    }
}
