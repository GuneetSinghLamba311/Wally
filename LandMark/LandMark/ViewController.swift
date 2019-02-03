//
//  ViewController.swift
//  LandMark
//
//  Created by Admin on 2019-02-01.
//  Copyright © 2019 Guneet SIngh Lamba. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct unspashImages{
    var imageURL:URL
}
 var pageCount = 1
class ViewController: UIViewController {
    
    var images = [unspashImages]()
    func getImageData() {
        let apiUrl = "https://api.unsplash.com/photos/?page=\(pageCount)&per_page=30&client_id=d5ce86c09abb18831d11a6f2268508cf79924775af2c3bc902b645246d23f6fe"
        Alamofire.request(apiUrl, method: .get, parameters: nil).responseJSON {
            
            (response) in
            
            if response.result.isSuccess {   /// if response give result then execute following code.
                
                if let dataFromServer = response.data { // getting data from response.
                    
                    
                    do {
                        let json = try JSON(data: dataFromServer) // Parsing Json received from server.
                        for i in 0...json.count - 1
                        {
                            
                            print(json[i]["urls"]["regular"])
                            self.images.append(unspashImages(imageURL: URL.init(string: String(describing: json[i]["urls"]["regular"]))!))
                        }
                        self.performSegue(withIdentifier: "toHome", sender: nil)
                    }
                    catch {
                        print("error")
                    }
                    
                }
                else {
                    print("Error when getting JSON from the response")
                }
            }
            
        }
        
    }
    override func viewDidLoad() {
    super.viewDidLoad()
        DispatchQueue.global().async {
            self.getImageData()
}
        
    }
    
       
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Passing data to another view controller where object another object of product-Structure is created. By this we can call all structue properties using loop.
       
        
        let ViewController =  segue.destination as? HomeController
        ViewController?.images = self.images
        
    }
}

        






