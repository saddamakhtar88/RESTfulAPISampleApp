//
//  ViewController.swift
//  RESTfulAPISampleApp
//
//  Created by Saddam Akhtar on 1/11/21.
//

import UIKit
import DependencyRegistry

class ViewController: UIViewController {

    @Inject() var imageSearchService: ImageSearchService
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = imageSearchService.getImages(for: "mango") { (result, error) in
            if error == nil && result != nil {
                print("Total images in first page is \(result!.images.count)")
            }
        }
    }
}
