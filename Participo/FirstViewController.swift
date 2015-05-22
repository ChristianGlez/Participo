//
//  FirstViewController.swift
//  Participo
//
//  Created by Rafael Rodriguez Adames on 5/22/15.
//  Copyright (c) 2015 Wovenware. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items = ["one", "two"]//TODO: include real data Object
    
    
    
    @IBOutlet weak var filterSectionsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.filterSectionsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell" )
        self.filterSectionsTableView.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.filterSectionsTableView
            .dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        cell.textLabel!.text = self.items[indexPath.row]
        return cell
    }
    
}
