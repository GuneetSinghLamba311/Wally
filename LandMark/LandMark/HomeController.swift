//
//  HomeController.swift
//  LandMark
//
//  Created by Admin on 2019-02-02.
//  Copyright © 2019 Guneet SIngh Lamba. All rights reserved.
//

import UIKit

struct imageData {
    var data:Data
}

class HomeController: UICollectionViewController {
    var images = [unspashImages]()
    var data = [imageData]()
    var refreshControl:UIRefreshControl!

    @IBOutlet var unsplashControllerView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        unsplashControllerView.delegate=self
        unsplashControllerView.dataSource=self
        unsplashControllerView.reloadData()
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
       unsplashControllerView.addSubview(refreshControl)
        print(images.count)
}
    @objc func refresh(sender:AnyObject)
    {
        pageCount = pageCount + 1
        
        self.performSegue(withIdentifier: "toLoad", sender: nil)
    }
    


    // MARK: UICollectionViewDataSource


  

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)as! customCell
        URLSession.shared.dataTask(with: images[indexPath.row].imageURL) { (data, resp, error) in
            
            if let data = data {
                OperationQueue.main.addOperation({
                    cell.unsplashImage.image = UIImage(data: data)
                })
            }
            }.resume()
      
        
        return cell
    }

}
