//
//  MediaListTableViewController.swift
//  PrjSportsNews
//
//  Created by TzuHuan Shao on 2019/5/30.
//  Copyright © 2019 FredShao. All rights reserved.
//

import UIKit

struct MediaItem {
    var name: String
    var type: String
    var image: String
}

class MediaListTableViewController: UITableViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    let mediaList:[MediaItem] = [MediaItem(name: "ETtoday"     , type: "體育新聞"       , image: "Ettoday"),
                                 MediaItem(name: "自由時報"      , type: "體育"          , image: "Ltn"),
                                 MediaItem(name: "Yahoo!奇摩"   , type: "體育新聞"       , image: "Yahoo"),
                                 MediaItem(name: "中華電視公司"  , type: "運動新聞"        , image: "Cts"),
                                 MediaItem(name: "中時電子報"    , type: "運動"           , image: "Ct"),
                                 MediaItem(name: "sina新浪台灣"  , type: "台灣體育"       , image: "Sina"),
                                 MediaItem(name: "udn聯合新聞網" , type: "運動(包含分類)"  , image: "Udn"),
                                 MediaItem(name: "運動視界"      , type: "(全站文章)"     , image: "SV")
                                ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(UINib(nibName: "MediaListTableViewCell", bundle: nil), forCellReuseIdentifier: "MediaListCell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaListCell", for: indexPath) as! MediaListTableViewCell
        cell.leftLabel.text  = mediaList[indexPath.row].type
        cell.rightLabel.text = mediaList[indexPath.row].name
        cell.linkOutlet.setImage(UIImage(named: mediaList[indexPath.row].image), for: .normal)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
