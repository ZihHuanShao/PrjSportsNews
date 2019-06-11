//
//  ViewController.swift
//  PrjSportsNews_v3
//
//  Created by Fred Shao on 2019/2/14.
//  Copyright © 2019年 FredShao. All rights reserved.
//

import UIKit
import AudioToolbox

struct NewsItem {
    var title: String? // News title
    var link : String? // News link
}

struct PublishersInfo {
    var publisher   : String
    var address     : String
    var logo        : String
}

fileprivate enum Media: String {
    case ettoday            = "ETtoday"
    case ltn                = "自由"
    case yahoo              = "雅虎"
    case cts                = "華視"
    case chinatimes         = "中時"
    case sina               = "新浪"
    case udnTWInNPB         = "UDN(台將征戰日職)"
    case udnCTBA            = "UDN(棒協賽事特報)"
    case udnNBA             = "UDN(NBA)"
    case udnBaseball        = "UDN(棒球)"
    case udnBaseball30Years = "UDN(中職30年)"//
    case udnMLB             = "UDN(MLB)"
    case udnBasketball      = "UDN(籃球)"
    case udnComprehensive   = "UDN(綜合)"
    case udnRunnig          = "UDN(路跑)"
    case svNBA              = "運動視界(NBA)"
    case svBasketball       = "運動視界(籃球)"
    case svMLB              = "運動視界(MLB)"
    case svCPBL             = "運動視界(CPBL)"
    case svNPB              = "運動視界(NPB)"
    case svBaseball         = "運動視界(棒球)"
    case svTennis           = "運動視界(網球)"
    case svVolleyball       = "運動視界(排球)"
    case svFootball         = "運動視界(足球)"
    case svBadminton        = "運動視界(羽球)"
    case svTabletennis      = "運動視界(桌球)"
    case svTrackandfield    = "運動視界(田徑)"
    case svSwimming         = "運動視界(游泳)"
    case svGolf             = "運動視界(高爾夫)"
    case svRunning          = "運動視界(路跑)"
    case svBike             = "運動視界(單車)"
    case svTriathlon        = "運動視界(鐵人三項)"
    case svXgames           = "運動視界(極限運動)"
    case svOthersports      = "運動視界(其他運動)"
    case svCarRacing        = "運動視界(賽車)"
    case svsSportsStored    = "運動視界(運動收藏)"
    case svNFL              = "運動視界(美足聯盟)"
    case svWrestle          = "運動視界(格鬥摔角)"
    case svFitness          = "運動視界(健身訓練)"
    case svSportLottery     = "運動視界(運彩)"
    case svCheerleading     = "運動視界(競技啦啦隊)"
    case svSki              = "運動視界(滑雪)"
    case svHiking           = "運動視界(登山健行)"
    case multiSports        = "運動視界(綜合運動)"
    
    static func getAllMedia() -> [Media] {
        return [.ettoday, .ltn, .yahoo, .cts, .chinatimes, .sina, udnTWInNPB, .udnCTBA, .udnNBA, .udnBaseball, .udnBaseball30Years, .udnMLB, .udnBasketball, .udnComprehensive, .udnRunnig, .svNBA, .svBasketball, .svMLB, .svCPBL, .svNPB, .svBaseball, .svTennis, .svVolleyball, .svFootball, .svBadminton, .svTabletennis, .svTrackandfield, .svSwimming, .svGolf, .svRunning, .svBike, .svTriathlon, .svXgames, .svOthersports, .svCarRacing, .svsSportsStored, .svNFL, .svWrestle, .svFitness, .svSportLottery, .svCheerleading, .svSki, .svHiking, .multiSports
               ]
    }
    
    // convert to enum
    static func convertIndexToValue(_ index: Int) -> Media {
        switch index {
        case 0:     return .ettoday
        case 1:     return .ltn
        case 2:     return .yahoo
        case 3:     return .cts
        case 4:     return .chinatimes
        case 5:     return .sina
        case 6:     return .udnTWInNPB
        case 7:     return .udnCTBA
        case 8:     return .udnNBA
        case 9:     return .udnBaseball
        case 10:    return .udnBaseball30Years
        case 11:    return .udnMLB
        case 12:    return .udnBasketball
        case 13:    return .udnComprehensive
        case 14:    return .udnRunnig
        case 15:    return .svNBA
        case 16:    return .svBasketball
        case 17:    return .svMLB
        case 18:    return .svCPBL
        case 19:    return .svNPB
        case 20:    return .svBaseball
        case 21:    return .svTennis
        case 22:    return .svVolleyball
        case 23:    return .svFootball
        case 24:    return .svBadminton
        case 25:    return .svTabletennis
        case 26:    return .svTrackandfield
        case 27:    return .svSwimming
        case 28:    return .svGolf
        case 29:    return .svRunning
        case 30:    return .svBike
        case 31:    return .svTriathlon
        case 32:    return .svXgames
        case 33:    return .svOthersports
        case 34:    return .svCarRacing
        case 35:    return .svsSportsStored
        case 36:    return .svNFL
        case 37:    return .svWrestle
        case 38:    return .svFitness
        case 39:    return .svSportLottery
        case 40:    return .svCheerleading
        case 41:    return .svSki
        case 42:    return .svHiking
        case 43:    return .multiSports
        default:    fatalError()
        }
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var upCollectionView     : UICollectionView!
    @IBOutlet weak var downCollectionView   : UICollectionView!
    
    private var currenctIndexPath   : IndexPath!
    private var parseFailDict       = [String:Bool]()
    private var medias              = Media.getAllMedia()
    private var allObjectDict       = [Media: [NewsItem]]()
    private var session             = URLSession(configuration: .default)
    private var isDownloading       = false
    private var publishersInfo      =
        [
            PublishersInfo(publisher: "ETtoday",         address: "http://feeds.feedburner.com/ettoday/sport?format=xml",   logo:"Ettoday_Icon-App-60x60"),
            PublishersInfo(publisher: "自由",             address: "https://news.ltn.com.tw/rss/sports.xml",                 logo:"Ltn_Icon-App-60x60"),
            PublishersInfo(publisher: "雅虎",             address: "https://tw.news.yahoo.com/rss/sports",                   logo:"Yahoo_Icon-App-60x60"),
            PublishersInfo(publisher: "華視",             address: "https://news.cts.com.tw/rss/sports.xml",                 logo:"Cts_Icon-App-60x60"),
            PublishersInfo(publisher: "中時",             address: "https://www.chinatimes.com/rss/realtimenews-sport.xml",  logo:"Ct_Icon-App-60x60"),
            PublishersInfo(publisher: "新浪",             address: "https://news.sina.com.tw/rss/sports/tw.xml",             logo:"Sina_Icon-App-60x60"),
            PublishersInfo(publisher: "UDN(台將征戰日職)",  address: "https://udn.com/rssfeed/news/2/7227/8280?ch=news",       logo:"Udn_Icon-App-60x60"),
            PublishersInfo(publisher: "UDN(棒協賽事特報)",  address: "https://udn.com/rssfeed/news/2/7227/12960?ch=news",      logo:"Udn_Icon-App-60x60"),
            PublishersInfo(publisher: "UDN(NBA)",         address: "https://udn.com/rssfeed/news/2/7227/7002?ch=news",       logo:"Udn_Icon-App-60x60"),
            PublishersInfo(publisher: "UDN(棒球)",         address: "https://udn.com/rssfeed/news/2/7227/7001?ch=news",       logo:"Udn_Icon-App-60x60"),
            PublishersInfo(publisher: "UDN(中職30年)",     address: "https://udn.com/rssfeed/news/2/7227/12822?ch=news",       logo:"Udn_Icon-App-60x60"),
            PublishersInfo(publisher: "UDN(MLB)",         address: "https://udn.com/rssfeed/news/2/7227/6999?ch=news",       logo:"Udn_Icon-App-60x60"),
            PublishersInfo(publisher: "UDN(籃球)",         address: "https://udn.com/rssfeed/news/2/7227/7003?ch=news",       logo:"Udn_Icon-App-60x60"),
            PublishersInfo(publisher: "UDN(綜合)",         address: "https://udn.com/rssfeed/news/2/7227/7005?ch=news",       logo:"Udn_Icon-App-60x60"),
            PublishersInfo(publisher: "UDN(路跑)",         address: "https://udn.com/rssfeed/news/2/7227/7879?ch=news",       logo:"Udn_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(NBA)",      address: "https://www.sportsv.net/nba/feed",                       logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(籃球)",      address: "https://www.sportsv.net/basketball/feed",                logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(MLB)",      address: "https://www.sportsv.net/mlb/feed",                       logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(CPBL)",     address: "https://www.sportsv.net/cpbl/feed",                      logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(NPB)",      address: "https://www.sportsv.net/npb/feed",                       logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(棒球)",      address: "https://www.sportsv.net/baseball/feed",                  logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(網球)",      address: "https://www.sportsv.net/tennis/feed",                    logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(排球)",      address: "https://www.sportsv.net/volleyball/feed",                logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(足球)",      address: "https://www.sportsv.net/football/feed",                  logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(羽球)",      address: "https://www.sportsv.net/badminton/feed",                 logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(桌球)",      address: "https://www.sportsv.net/tabletennis/feed",               logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(田徑)",      address: "https://www.sportsv.net/trackandfield/feed",             logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(游泳)",      address: "https://www.sportsv.net/swimming/feed",                  logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(高爾夫)",    address: "https://www.sportsv.net/golf/feed",                      logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(路跑)",      address: "https://www.sportsv.net/running/feed",                   logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(單車)",      address: "https://www.sportsv.net/bike/feed",                      logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(鐵人三項)",   address: "https://www.sportsv.net/triathlon/feed",                 logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(極限運動)",   address: "https://www.sportsv.net/xgames/feed",                    logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(其他運動)",   address: "https://www.sportsv.net/othersports/feed",               logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(賽車)",      address: "https://www.sportsv.net/f1/feed",                        logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(運動收藏)",   address: "https://www.sportsv.net/memorabilia/feed",               logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(美足聯盟)",   address: "https://www.sportsv.net/nfl/feed",                       logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(格鬥摔角)",   address: "https://www.sportsv.net/wrestling/feed",                 logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(健身訓練)",   address: "https://www.sportsv.net/fitness/feed",                   logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(運彩)",      address: "https://www.sportsv.net/sportslottery/feed",             logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(競技啦啦隊)", address: "https://www.sportsv.net/cheerleading/feed",              logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(滑雪)",      address: "https://www.sportsv.net/ski/feed",                       logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(登山健行)",   address: "https://www.sportsv.net/hiking/feed",                    logo:"SportsVision_Icon-App-60x60"),
            PublishersInfo(publisher: "運動視界(綜合運動)",   address: "http://www.sportsv.net/othersports/feed",                logo:"SportsVision_Icon-App-60x60"),

    ]
    
    @IBAction func leftBarButtonAction(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "軟體資訊", message: "", preferredStyle: .actionSheet)
        
        let firstAction = UIAlertAction(title: "最新公告", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            let storyboard              = UIStoryboard(name: "Main", bundle: nil)
            let latestBulletinViewController   = storyboard.instantiateViewController(withIdentifier: "LatestBulletinViewController") as! LatestBulletinViewController
            latestBulletinViewController.title = "最新公告"
            self.navigationController?.pushViewController(latestBulletinViewController, animated: true)
        })
        
        let secondAction = UIAlertAction(title: "關於App", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            let storyboard              = UIStoryboard(name: "Main", bundle: nil)
            let aboutMeViewController   = storyboard.instantiateViewController(withIdentifier: "AboutMeViewController") as! AboutMeViewController
            aboutMeViewController.title = "關於App"
            self.navigationController?.pushViewController(aboutMeViewController, animated: true)
        })
        
        let thirdAction = UIAlertAction(title: "關於版權", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            let storyboard              = UIStoryboard(name: "Main", bundle: nil)
            let aboutMeViewController   = storyboard.instantiateViewController(withIdentifier: "SecondPageViewController") as! SecondPageViewController
            aboutMeViewController.title = "關於版權"
            self.navigationController?.pushViewController(aboutMeViewController, animated: true)
        })
        
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        alertController.addAction(thirdAction)
        present(alertController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDataSource()
        updateUI()
    }
    
    private func updateDataSource() {
        for index in 0...Media.getAllMedia().count - 1 {
            downloadXML(publishersInfo[index].address, index)
        }
        AudioServicesPlaySystemSound(1000)
    }
    
    private func updateUI() {
        //self.upCollectionView.isPagingEnabled = true
        upCollectionView.delegate       = self
        upCollectionView.dataSource     = self
        downCollectionView.delegate     = self
        downCollectionView.dataSource   = self
        
        currenctIndexPath = IndexPath(row: 0, section: 0)
        downCollectionView.register(UINib(nibName: "TableViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TableViewCollectionViewCell")
    }
    
    @IBAction func rightBarButtonAction(_ sender: UIBarButtonItem) {
        updateDataSource()
        self.title = "台灣體育新聞"
    }
    
    func downloadXML(_ xmlAddress: String, _ publisherIndex: Int) {
        if let url = URL(string: xmlAddress) {
            let task = session.dataTask(with: url) {
                (data, urlResponse, error) in
                if error != nil {
                    DispatchQueue.main.async {
                        self.popAlert(withTitle: "Sorry")
                    }
                    self.isDownloading = false
                    return
                }
                
                if let okData = data {
                    let parser = XMLParser(data: okData)
                    let rssParserDelegate = RssParserDelegate()
                    parser.delegate = rssParserDelegate
                    
                    if parser.parse() == true {
                        
                        switch self.medias[publisherIndex] {
                        case .ettoday:              self.allObjectDict[.ettoday]            = rssParserDelegate.getResult()
                        case .ltn:                  self.allObjectDict[.ltn]                = rssParserDelegate.getResult()
                        case .yahoo:                self.allObjectDict[.yahoo]              = rssParserDelegate.getResult()
                        case .cts:                  self.allObjectDict[.cts]                = rssParserDelegate.getResult()
                        case .chinatimes:           self.allObjectDict[.chinatimes]         = rssParserDelegate.getResult()
                        case .sina:                 self.allObjectDict[.sina]               = rssParserDelegate.getResult()
                        case .udnTWInNPB:           self.allObjectDict[.udnTWInNPB]         = rssParserDelegate.getResult()
                        case .udnCTBA:              self.allObjectDict[.udnCTBA]            = rssParserDelegate.getResult()
                        case .udnNBA:               self.allObjectDict[.udnNBA]             = rssParserDelegate.getResult()
                        case .udnBaseball:          self.allObjectDict[.udnBaseball]        = rssParserDelegate.getResult()
                        case .udnBaseball30Years:   self.allObjectDict[.udnBaseball30Years] = rssParserDelegate.getResult()
                        case .udnMLB:               self.allObjectDict[.udnMLB]             = rssParserDelegate.getResult()
                        case .udnBasketball:        self.allObjectDict[.udnBasketball]      = rssParserDelegate.getResult()
                        case .udnComprehensive:     self.allObjectDict[.udnComprehensive]   = rssParserDelegate.getResult()
                        case .udnRunnig:            self.allObjectDict[.udnRunnig]          = rssParserDelegate.getResult()
                        case .svNBA:                self.allObjectDict[.svNBA]              = rssParserDelegate.getResult()
                        case .svBasketball:         self.allObjectDict[.svBasketball]       = rssParserDelegate.getResult()
                        case .svMLB:                self.allObjectDict[.svMLB]              = rssParserDelegate.getResult()
                        case .svCPBL:               self.allObjectDict[.svCPBL]             = rssParserDelegate.getResult()
                        case .svNPB:                self.allObjectDict[.svNPB]              = rssParserDelegate.getResult()
                        case .svBaseball:           self.allObjectDict[.svBaseball]         = rssParserDelegate.getResult()
                        case .svTennis:             self.allObjectDict[.svTennis]           = rssParserDelegate.getResult()
                        case .svVolleyball:         self.allObjectDict[.svVolleyball]       = rssParserDelegate.getResult()
                        case .svFootball:           self.allObjectDict[.svFootball]         = rssParserDelegate.getResult()
                        case .svBadminton:          self.allObjectDict[.svBadminton]        = rssParserDelegate.getResult()
                        case .svTabletennis:        self.allObjectDict[.svTabletennis]      = rssParserDelegate.getResult()
                        case .svTrackandfield:      self.allObjectDict[.svTrackandfield]    = rssParserDelegate.getResult()
                        case .svSwimming:           self.allObjectDict[.svSwimming]         = rssParserDelegate.getResult()
                        case .svGolf:               self.allObjectDict[.svGolf]             = rssParserDelegate.getResult()
                        case .svRunning:            self.allObjectDict[.svRunning]          = rssParserDelegate.getResult()
                        case .svBike:               self.allObjectDict[.svBike]             = rssParserDelegate.getResult()
                        case .svTriathlon:          self.allObjectDict[.svTriathlon]        = rssParserDelegate.getResult()
                        case .svXgames:             self.allObjectDict[.svXgames]           = rssParserDelegate.getResult()
                        case .svOthersports:        self.allObjectDict[.svOthersports]      = rssParserDelegate.getResult()
                        case .svCarRacing:          self.allObjectDict[.svCarRacing]        = rssParserDelegate.getResult()
                        case .svsSportsStored:      self.allObjectDict[.svsSportsStored]    = rssParserDelegate.getResult()
                        case .svNFL:                self.allObjectDict[.svNFL]              = rssParserDelegate.getResult()
                        case .svWrestle:            self.allObjectDict[.svWrestle]          = rssParserDelegate.getResult()
                        case .svFitness:            self.allObjectDict[.svFitness]          = rssParserDelegate.getResult()
                        case .svSportLottery:       self.allObjectDict[.svSportLottery]     = rssParserDelegate.getResult()
                        case .svCheerleading:       self.allObjectDict[.svCheerleading]     = rssParserDelegate.getResult()
                        case .svSki:                self.allObjectDict[.svSki]              = rssParserDelegate.getResult()
                        case .svHiking:             self.allObjectDict[.svHiking]           = rssParserDelegate.getResult()
                        case .multiSports:          self.allObjectDict[.multiSports]        = rssParserDelegate.getResult()

                        }
                        DispatchQueue.main.async {
                            self.downCollectionView.reloadData()
                        }
                        self.isDownloading = false
                    } else {
                        
                        print("dbg: parse fail! @\(self.medias[publisherIndex])")
                        self.parseFailDict[self.publishersInfo[publisherIndex].publisher] = true   // save the publisher name into dictionary if parse fail
                        self.isDownloading = false
                        if self.currenctIndexPath.row == 0 && self.currenctIndexPath.section == 0 {
                            if let okParseFailDictValue = self.parseFailDict["ETtoday"] {
                                if okParseFailDictValue == true {
                                    self.popAlert(withTitle: "糟糕:『\(self.publishersInfo[self.currenctIndexPath.row].publisher)』網頁資源發生問題!")
                                }
                                
                                self.currenctIndexPath.row += 1
                                self.upCollectionView.scrollToItem(at: self.currenctIndexPath, at: .centeredHorizontally, animated: true)
                                self.downCollectionView.scrollToItem(at: self.currenctIndexPath, at: .centeredHorizontally, animated: true)
                                self.upCollectionView.reloadData()
                            }
                        }
                    }
                } else {
                    self.isDownloading = false
                }
            }
            task.resume()
            self.isDownloading = true
        }
    }
    
    func popAlert(withTitle title: String) {
        let alert = UIAlertController(title: title, message: "Please try again later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.title = publishersInfo[indexPath.row].publisher // change navigation bar title
        switch collectionView {
        case upCollectionView:
            if parseFailDict[publishersInfo[indexPath.row].publisher] == true {
                popAlert(withTitle: "『\(publishersInfo[indexPath.row].publisher)』網頁資源發生問題!")
            } else {
                currenctIndexPath = indexPath
                upCollectionView.scrollToItem(at: currenctIndexPath, at: .centeredHorizontally, animated: true)
                downCollectionView.scrollToItem(at: currenctIndexPath, at: .centeredHorizontally, animated: true)
                upCollectionView.reloadData()
                break
            }
        case downCollectionView:
            break
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case upCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellA", for: indexPath) as! LabelCollectionViewCell
            cell.myLabel.text           = publishersInfo[indexPath.row].publisher
            cell.myLabel.numberOfLines  = 2
            return cell
            
        case downCollectionView:
            let cell            = collectionView.dequeueReusableCell(withReuseIdentifier: "TableViewCollectionViewCell", for: indexPath) as! TableViewCollectionViewCell
            let currentMedia    = Media.convertIndexToValue(indexPath.row)
            if let okAllObjectDictValue = allObjectDict[currentMedia] {
                cell.newsInfoFromVC = okAllObjectDictValue
            }
            cell.newsLogoFromVC = publishersInfo[indexPath.row].logo
            cell.delegate       = self  // Assign UICollectionViewDataSource protocol to ViewController
            cell.updateUI()
            return cell
            
        default:
            fatalError()
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case upCollectionView:
            return publishersInfo.count
        case downCollectionView:
            //            return allObjectDict[Media.ettoday] == nil ? 0 : publishersInfo.count
            return publishersInfo.count
        default:
            fatalError()
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case upCollectionView:
            return CGSize(width: 100, height: 50)
            
        case downCollectionView:
            return CGSize(width: downCollectionView.frame.width , height: downCollectionView.frame.height)
            
        default:
            fatalError()
        }
    }
}

// Implement Protocol: didTapCell
extension ViewController: TableCollectionViewCellDelegate {
    func didTapCell(_ link: String) {
        let storyboard                   = UIStoryboard(name: "Webview", bundle: nil)
        let webviewViewController        = storyboard.instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        webviewViewController.linkFromVC = link
        webviewViewController.title      = publishersInfo[currenctIndexPath.row].publisher
        self.navigationController?.pushViewController(webviewViewController, animated: true)
    }
}
