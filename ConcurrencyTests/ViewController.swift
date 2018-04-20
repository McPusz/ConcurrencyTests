//
//  ViewController.swift
//  ConcurrencyTests
//
//  Created by Magdusz on 11.04.2018.
//  Copyright © 2018 com.mcpusz.ConcurrencyTests. All rights reserved.
//

import UIKit

let imageURLS = [
    "https://wallpaperscraft.com/image/cat_surprise_look_striped_96597_3840x2160.jpg",
    "https://wallpaper.wiki/wp-content/uploads/2017/05/Cat-Wallpapers-background-for-PC.jpg",
    "https://wallpapers.pub/web/wallpapers/red-cat/4096x2160.jpg",
    "http://www.wallpixa.com/wp-content/uploads/2018/03/Animals-Image-4k-Background-HD-Picture-thirsty-cat-wallpaper-1920x1200.jpg"
]

class ImageDownloader {
    class func getImage(for imageString: String) -> UIImage? {
        guard let imageURL = URL(string: imageString), let imageData = try? Data(contentsOf: imageURL), let image = UIImage(data: imageData) else { return nil }
    
        return image
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var fourthImage: UIImageView!
    private var imageViews: [UIImageView] {
        return [self.firstImage, self.secondImage, self.thirdImage, self.fourthImage]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.addTarget(self, action: #selector(sliderValueChanged(slider:)), for: .valueChanged)
    }
    
    @IBAction func downloadImages(_ sender: Any) {
        self.imageViews.forEach{ $0.image = nil }
        
        let queue = DispatchQueue.global()
        
        queue.async {
            let img1 = ImageDownloader.getImage(for: imageURLS[0])
            DispatchQueue.main.async {
                self.firstImage.image = img1
            }
        }
        
        queue.async {
            let img2 = ImageDownloader.getImage(for: imageURLS[1])
            DispatchQueue.main.async {
                self.secondImage.image = img2
            }
        }
        
        queue.async {
            let img3 = ImageDownloader.getImage(for: imageURLS[2])
            DispatchQueue.main.async {
                self.thirdImage.image = img3
            }
        }
        
        queue.async {
            let img4 = ImageDownloader.getImage(for: imageURLS[3])
            DispatchQueue.main.async {
                self.fourthImage.image = img4
            }
        }
    }
    
    @objc func sliderValueChanged(slider: UISlider) {
        percentLabel.text = String(format: "%.f", slider.value*100)
    }
}

