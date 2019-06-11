//
//  LatestBulletinViewController.swift
//  PrjSportsNews
//
//  Created by TzuHuan Shao on 2019/5/31.
//  Copyright © 2019 FredShao. All rights reserved.
//

import UIKit

struct RevisionInfo {
    var rev: String
    var info: String
}

class LatestBulletinViewController: UIViewController {
    @IBOutlet weak var revisionInfoLabel: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    
    // Edit revision information here when updating the version each time
    let revisionInfo = [RevisionInfo(rev: "Rev 1.0.0", info: "Release")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        revisionInfoLabel.clipsToBounds       = true
        revisionInfoLabel.layer.cornerRadius  = 8
        
        myTableView.dataSource = self
//        myTableView.delegate = self
        myTableView.register(UINib(nibName: "LatestBulletinTableViewCell", bundle: nil), forCellReuseIdentifier: "LatestBulletinCell")
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

extension LatestBulletinViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return revisionInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LatestBulletinCell", for: indexPath) as! LatestBulletinTableViewCell
        cell.revisionLabel.text = revisionInfo[indexPath.row].rev
        cell.infoLabel.text     = revisionInfo[indexPath.row].info
        
        return cell
    }
    
    
}

//extension LatestBulletinViewController: UITableViewDelegate {
//    
//}
