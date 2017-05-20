//
//  UrlResource.swift
//  HotUrl
//
//  Created by Marco Agovino on 10.05.17.
//  Copyright © 2017 Marco Agovino. All rights reserved.
//

import Foundation
// Protocol für die Klasse ArrayResource

// gib mir ein Array mit den Listeneinträgen

protocol UrlResource {
    func getList() -> [HotUrl]

}
