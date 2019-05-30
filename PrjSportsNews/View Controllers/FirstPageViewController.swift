//
//  FirstPageViewController.swift
//  PrjSportsNews
//
//  Created by TzuHuan Shao on 2019/5/29.
//  Copyright © 2019 FredShao. All rights reserved.
//

import UIKit

class FirstPageViewController: UIViewController {
    var checkBoxState = Bool()
    @IBOutlet weak var changeOkButton: UIButton!
    
    @IBAction func okButton(_ sender: UIButton) {
        if checkBoxState {
            performSegue(withIdentifier: "gotoPage2", sender: nil)
        }
    }
    
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        if sender.isSelected {
            checkBoxState     = false
            sender.isSelected = false
            changeOkButton.setTitleColor(.lightGray, for: .normal)
            
        } else {
            checkBoxState     = true
            sender.isSelected = true
            changeOkButton.setTitleColor(.white, for: .normal)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        changeOkButton.setTitleColor(.lightGray, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
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
