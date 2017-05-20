//
//  ArrayResource.swift
//  HotUrl
//
//  Created by Marco Agovino on 10.05.17.
//  Copyright © 2017 Marco Agovino. All rights reserved.
//

import Foundation

struct ArrayResource: UrlResource {

    // func von Prototyp einbinden
    func getList() -> [HotUrl] {
        
        // eine liste von HotUrl als leeres array initialisieren
        var hotUrls = [HotUrl]()
        
        // Beispiel - Einträge
        hotUrls.append(HotUrl(name: "Meine Webseite", url: "www.agovino.ch"))
        
        hotUrls.append(HotUrl(name: "FHNW-Webseite", url: "www.fhnw.ch"))
        
        return hotUrls
    }
}
