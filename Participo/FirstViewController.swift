//
//  FirstViewController.swift
//  Participo
//
//  Created by Rafael Rodriguez Adames on 5/22/15.
//  Copyright (c) 2015 Wovenware. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
   
    
    var objects: NSMutableArray! = NSMutableArray()
    
    //var sessionsDictionary: NSMutableDictionary! = ["mekey":"response"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //load data from Mondo DB API by Christian
        let url = NSURL(string: "http://10.100.3.144:8080/Participo/services/sessions/all")
        let request = NSURLRequest(URL: url!)
        /*
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
            {
                (response, data, error) in
            println(NSString(data: data!, encoding: NSUTF8StringEncoding))
        }
        */
        
        var response: NSURLResponse?
        var error: NSError?
        var data: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&error)
        println("data: \(data)")
        
        if let data: NSData! = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&error) {
            println("data: \(data!)")
            
            var parsingError: NSError?
            if let sessions = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &parsingError) as! NSArray? {
                //println("rateDictionary: \(rateDictionary)")
                
                var response: [AnyObject] = sessions as! [AnyObject]
                
                
               
                
                for var i=0; i<sessions.count; i++ {
                    println(sessions[i]["name"])
                    var r1: AnyObject? = response[i]["name"]!
                    
                   self.objects.addObject("\(r1!)")
                }
                
                
            }
        }
        
        
        self.tableView.reloadData()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        
        cell.titleLabel.text = self.objects.objectAtIndex(indexPath.row) as? String
        
        cell.shareButton.tag = indexPath.row//send with is
        
        cell.shareButton.addTarget(self, action: "logAction", forControlEvents: .TouchUpInside)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showView", sender: self)
    }
    
    @IBAction func logAction(sender: UIButton)
    {
        let titleString = self.objects.objectAtIndex(sender.tag) as? String
        
        let firstActivityItem = "\(titleString)"
        
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [firstActivityItem], applicationActivities: nil)
        self.presentViewController(activityViewController, animated: true, completion: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "showView"){
        
        var upcoming: NewViewController = segue.destinationViewController as! NewViewController
        
        let indexPath = self.tableView.indexPathForSelectedRow()!
        
        let titleString = self.objects.objectAtIndex(indexPath.row) as? String
        
        upcoming.titleString = titleString
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
