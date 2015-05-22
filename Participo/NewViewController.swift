//
//  NewViewController.swift
//  Participo
//
//  Created by Rafael Rodriguez Adames on 5/22/15.
//  Copyright (c) 2015 Wovenware. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var sypText: UITextView!
    
    @IBOutlet weak var y1: UIImageView!
    @IBOutlet weak var y2: UIImageView!
    @IBOutlet weak var y3: UIImageView!
    @IBOutlet weak var y4: UIImageView!
    @IBOutlet weak var y5: UIImageView!
    
    @IBOutlet weak var b1: UIImageView!
    @IBOutlet weak var b2: UIImageView!
    @IBOutlet weak var b3: UIImageView!
    @IBOutlet weak var b4: UIImageView!
    @IBOutlet weak var b5: UIImageView!
    
    @IBOutlet weak var mySlide: UISlider!
    
    @IBAction func slide(sender: AnyObject) {
        var rating = Int(mySlide.value)
        
        if rating == 1 {
            b1.hidden = true
            y1.hidden = false
            b2.hidden = false
            y2.hidden = true
        } else if rating == 2 {
            b2.hidden = true
            y2.hidden = false
            b3.hidden = false
            y3.hidden = true
        } else if rating == 3 {
            b3.hidden = true
            y3.hidden = false
            b4.hidden = false
            y4.hidden = true
        } else if rating == 4 {
            b4.hidden = true
            y4.hidden = false
            b5.hidden = false
            y5.hidden = true
        } else if rating == 5 {
            b5.hidden = true
            y5.hidden = false
        }
    }
    
    
    var titleString: String!
    
    var syTextString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = self.titleString
        
        self.sypText.text = self.syTextString
        
        var id: Int = 1
        
        //load data from Mondo DB API by Christian
        let url = NSURL(string: "http://10.100.3.144:8080/Participo/services/sessions/details/\(id)")
        let request = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
        {
        (response, data, error) in
        println(NSString(data: data!, encoding: NSUTF8StringEncoding))
        }

        
        
        
        var response: NSURLResponse?
        var error: NSError?
        var data: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&error)
        println("data: \(data)")
        
        if let data: NSData! = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&error) {
            println("data: \(data!)")
        
            var parsingError: NSError?
            if let sessions = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &parsingError) as! NSDictionary? {
                //println("rateDictionary: \(rateDictionary)")
                var rateString: AnyObject = sessions["description"]!
                self.sypText.text = rateString as! String
                
                
                
            }
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        b1.hidden = true
        y1.hidden = false
        b2.hidden = false
        y2.hidden = true
        b3.hidden = false
        y3.hidden = true
        b4.hidden = false
        y4.hidden = true
        b5.hidden = false
        y5.hidden = true
        //self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
