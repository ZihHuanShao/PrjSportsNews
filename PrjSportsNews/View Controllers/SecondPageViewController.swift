//
//  SecondPageViewController.swift
//  PrjSportsNews
//
//  Created by TzuHuan Shao on 2019/5/29.
//  Copyright © 2019 FredShao. All rights reserved.
//

import UIKit

class SecondPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
//        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 200, green: 70, blue: 61, alpha: 1.0)
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
