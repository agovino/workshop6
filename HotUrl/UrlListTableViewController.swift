//
//  ViewController.swift
//  HotUrl
//
//  Created by Marco Agovino on 10.05.17.
//  Copyright © 2017 Marco Agovino. All rights reserved.
//

import UIKit

class UrlListTableViewController: UITableViewController {

    // ein Array aus HotUrl - Objekten
    var urlList = [HotUrl](){
        // verbinden eines Property-Observer
        didSet {
            // die Tabelle wurde verändert
            tableView.reloadData()
        }
    }
    
    // Delegate - Referenz (Meine AppDelegate in Model)
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            // liste jetzt füllen
            urlList = appDelegate.urlResource.getList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        urlList = [HotUrl]()
    }
    
    // Number of Rows in Section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Anzahl der Elemente == ZeilenAnzahl
        return urlList.count
    }
    
    // identifier im storyboard festlegen
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Referenz auf der möglichen queu 
        // Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "urlCell", for: indexPath)
        
        // initialisieren des HotUrl Objects mit Name & URL
        let hotUrl = urlList[indexPath.row]
        cell.textLabel?.text = hotUrl.name
        return cell
        
    }


}

