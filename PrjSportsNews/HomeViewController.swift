//
//  HomeViewController.swift
//  PrjSportsNews_v3
//
//  Created by Fred Shao on 2019/2/19.
//  Copyright © 2019年 FredShao. All rights reserved.
//

import UIKit

protocol HomeCollectionViewCellDelegate: class {
    func didHomeItemCell(_ link: IndexPath)
}

struct PublishersLogo {
    var publisher   : String
    var logo        : String
}

class HomeViewController: UIViewController {
    @IBOutlet weak var homeCollectionView   : UICollectionView!
    weak var delegate                       : HomeCollectionViewCellDelegate?
    private var publishersLogoList          = [
//                                               PublishersLogo(publisher: "教育部體育署", logo: "Sa_Icon-App-60x60"),
                                               PublishersLogo(publisher: "ETtoday"   , logo: "Ettoday_Icon-App-60x60"),
                                               PublishersLogo(publisher: "自由"       , logo: "Ltn_Icon-App-60x60"),
                                               PublishersLogo(publisher: "雅虎"       , logo: "Yahoo_Icon-App-60x60"),
                                               PublishersLogo(publisher: "PCHOME"    , logo: "PChome_Icon-App-60x60"),
                                               PublishersLogo(publisher: "華視"       , logo: "Cts_Icon-App-60x60"),
                                               PublishersLogo(publisher: "中時"       , logo: "Ct_Icon-App-60x60"),
                                               PublishersLogo(publisher: "新浪"       , logo: "Sina_Icon-App-60x60"),
                                               PublishersLogo(publisher: "UDN"       , logo: "Udn_Icon-App-60x60"),
                                               PublishersLogo(publisher: "運動視界"    , logo: "SportsVision_Icon-App-60x60"),
                                               ]

    override func viewDidLoad() {
        super.viewDidLoad()
        homeCollectionView.dataSource   = self
        homeCollectionView.delegate     = self
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return publishersLogoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell                 = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        cell.homePageImage.image = UIImage(named: publishersLogoList[indexPath.row].logo)
        cell.homePageLabel.text  = publishersLogoList[indexPath.row].publisher
        return cell
    }
}

extension HomeViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 1) / 2
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
