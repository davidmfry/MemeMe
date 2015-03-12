//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by David on 3/12/15.
//  Copyright (c) 2015 David Fry. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var savedMeme: Meme!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.imageView.image = savedMeme.memedImage
    }
    

}
