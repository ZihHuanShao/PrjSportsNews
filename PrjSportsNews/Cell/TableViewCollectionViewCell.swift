//
//  TableViewCollectionViewCell.swift
//  PrjSportsNews_v3
//
//  Created by Fred Shao on 2019/2/14.
//  Copyright © 2019年 FredShao. All rights reserved.
//

import UIKit

protocol TableCollectionViewCellDelegate: class {
    func didTapCell(_ link: String)
}

class TableViewCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var myTableView  : UITableView!
    weak var delegate               : TableCollectionViewCellDelegate?
    var newsLogoFromVC              : String?
    var newsInfoFromVC              = [NewsItem]()
    var indexPath                   : IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.myTableView.delegate   = self
        self.myTableView.dataSource = self
        let infoNib                 = UINib(nibName: "InformationCell", bundle: nil)
        self.myTableView.register(infoNib, forCellReuseIdentifier: "InformationCell")
    }
    
    func updateUI() {
        self.myTableView.reloadData()
    }
}

extension TableViewCollectionViewCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate?.didTapCell(newsInfoFromVC[indexPath.row].link!)
    }
}

extension TableViewCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsInfoFromVC.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InformationCell", for: indexPath) as! InformationCell
        cell.titleLabel.text = newsInfoFromVC[indexPath.row].title
        if let okNewsLogoFromVC = newsLogoFromVC {
            cell.mainImageView.image = UIImage(named: okNewsLogoFromVC)
        }
        cell.indicatorImageView.image = UIImage(named: "Arror_Icon-App-60x60")
        return cell
    }
}
