//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by David on 3/12/15.
//  Copyright (c) 2015 David Fry. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{

    @IBOutlet weak var collectionView: UICollectionView!
    
    var memes: [Meme]!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        println((UIApplication.sharedApplication().delegate as AppDelegate).memes)
        self.collectionView.reloadData()
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        println((UIApplication.sharedApplication().delegate as AppDelegate).memes.count)
        return (UIApplication.sharedApplication().delegate as AppDelegate).memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("CUSTOM-MEME-CELL", forIndexPath: indexPath) as MemeCollectionViewCell
        cell.topLabel.text = (UIApplication.sharedApplication().delegate as AppDelegate).memes[indexPath.item].topTitle
        cell.bottomLabel.text = (UIApplication.sharedApplication().delegate as AppDelegate).memes[indexPath.item].bottomTitle
        cell.memeImageView.image = (UIApplication.sharedApplication().delegate as AppDelegate).memes[indexPath.item].image!
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "toMemeDetailView"
        {
            let detailVC = segue.destinationViewController as MemeDetailViewController
            var memeIndex = self.collectionView.indexPathForCell(sender as MemeCollectionViewCell)?.row
            detailVC.savedMeme = (UIApplication.sharedApplication().delegate as AppDelegate).memes[memeIndex!]
        }
        
    }
    
    
    func setCell(cell: MemeCollectionViewCell, topText:String, bottomText:String, backgroundImage:UIImage)
    {
        cell.topLabel.text = topText
        cell.bottomLabel.text = bottomText
        cell.memeImageView.image = backgroundImage
    }
    
    
    

   

}
