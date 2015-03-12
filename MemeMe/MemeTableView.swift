//
//  MemeTableView.swift
//  MemeMe
//
//  Created by David on 3/11/15.
//  Copyright (c) 2015 David Fry. All rights reserved.
//

import UIKit

class MemeTableView: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
    
    var memes: [Meme]!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        

// This code does not work, but in the lesson it said to add this in
//        let object = UIApplication.sharedApplication().delegate
//        let appDelegate = object as AppDelegate
//        memes = appDelegate.memes


    }
    
    override func viewDidAppear(animated: Bool)
    {
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (UIApplication.sharedApplication().delegate as AppDelegate).memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("TABLECELL", forIndexPath: indexPath) as UITableViewCell
        cell.imageView?.image = (UIApplication.sharedApplication().delegate as AppDelegate).memes[indexPath.row].memedImage
        cell.textLabel?.text = (UIApplication.sharedApplication().delegate as AppDelegate).memes[indexPath.row].topTitle

        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "toMemeDetailView"
        {
            let detailVC = segue.destinationViewController as MemeDetailViewController
            var memeIndex = self.tableView.indexPathForSelectedRow()?.row
            detailVC.savedMeme = (UIApplication.sharedApplication().delegate as AppDelegate).memes[memeIndex!]
        }
        
    }
    
    
    
    
    
}
