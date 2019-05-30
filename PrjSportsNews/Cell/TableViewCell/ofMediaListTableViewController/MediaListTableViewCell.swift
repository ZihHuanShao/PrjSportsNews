//
//  MediaListTableViewCell.swift
//  PrjSportsNews
//
//  Created by TzuHuan Shao on 2019/5/30.
//  Copyright © 2019 FredShao. All rights reserved.
//

import UIKit

class MediaListTableViewCell: UITableViewCell {

    @IBOutlet weak var leftLabel:  UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var linkOutlet: UIButton!
    
    @IBAction func myLink(_ sender: UIButton) {
        switch sender.currentImage {
        case UIImage(named: "Ettoday"):
            UIApplication.shared.open(URL(string: "https://www.ettoday.net/events/news-express/epaper.php")!, options: [:], completionHandler: nil)
        case UIImage(named: "Ltn"):
            UIApplication.shared.open(URL(string: "https://news.ltn.com.tw/service/8")!, options: [:], completionHandler: nil)
        case UIImage(named: "Yahoo"):
            UIApplication.shared.open(URL(string: "https://tw.info.yahoo.com/rss/")!, options: [:], completionHandler: nil)
        case UIImage(named: "Cts"):
            UIApplication.shared.open(URL(string: "https://news.cts.com.tw/plugin/")!, options: [:], completionHandler: nil)
        case UIImage(named: "Ct"):
            UIApplication.shared.open(URL(string: "https://forums.chinatimes.com/report/RSS/RSS.htm")!, options: [:], completionHandler: nil)
        case UIImage(named: "Sina"):
            UIApplication.shared.open(URL(string: "https://news.sina.com.tw/rss/index.html")!, options: [:], completionHandler: nil)
        case UIImage(named: "Udn"):
            UIApplication.shared.open(URL(string: "https://udn.com/rssfeed/lists/2")!, options: [:], completionHandler: nil)
        case UIImage(named: "SV"):
            UIApplication.shared.open(URL(string: "https://www.sportsv.net/announce/12")!, options: [:], completionHandler: nil)
        default:
            fatalError()
        }

    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
