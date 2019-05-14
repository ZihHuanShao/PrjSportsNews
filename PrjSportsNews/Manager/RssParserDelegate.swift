//
//  RssParserDelegate.swift
//  PrjSportsNews_v3
//
//  Created by Fred Shao on 2019/2/15.
//  Copyright © 2019年 FredShao. All rights reserved.
//

import Foundation

class RssParserDelegate: NSObject, XMLParserDelegate {
    var currentItem         : NewsItem?
    var currentElementValue : String?
    var resultArray         = [NewsItem]()

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item" {
            currentItem = NewsItem()
        } else if elementName == "title" {
            currentElementValue = nil
        } else if elementName == "link" {
            currentElementValue = nil
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            if currentItem != nil {
                resultArray.append(currentItem!)
                currentItem = nil
            }
        } else if elementName == "title" {
            currentItem?.title = currentElementValue
        } else if elementName == "link" {
            currentItem?.link = currentElementValue
        }
        currentElementValue = nil // All the items can be ignored except for the <item>, <title> and <link>
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if string == "\n\t\t\t\t" || string == "\n\t\t\t" {
            // do nothing for parsing <item> of ETtodays
        } else if currentElementValue == nil {
            currentElementValue = string
        } else {
            currentElementValue = currentElementValue! + string
        }
    }

    func getResult() -> [NewsItem] {
        return resultArray
    }
}
