//
//  ViewController.swift
//  UIActivityApp
//
//  Created by Nobuhiro Takahashi on 2018/07/05.
//  Copyright © 2018年 Nobuhiro Takahashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonWasTapped(_ sender: Any) {
        share()
    }
    
    func share() {
        let shareText = ActivityText(text: "hogehoge")
        let shareUrl = URL(string: "https://developer.apple.com/")!
        // CC0 License
        // https://www.pexels.com/photo/digital-clock-at-7-34-pm-890849/
        let shareImage = UIImage(named: "books-clock-clockwork-890849.jpg")!
        
        let items = [shareText, shareUrl, shareImage] as [Any]
        
        let vc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        vc.excludedActivityTypes = [UIActivityType.assignToContact]
        
        // deals for iPad
        vc.popoverPresentationController?.sourceView = self.view
        vc.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width / 2.0, y: view.bounds.size.height / 2.0, width: 1.0, height: 1.0)
        
        present(vc, animated: true, completion: nil)
    }
}

// Twitter 用にハッシュタグをつける
class ActivityText: NSObject, UIActivityItemSource {
    static let HASH_TAG = " #ios"
    var text: String = ""
    
    init(text:String) {
        self.text = text
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return text
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivityType?) -> Any? {
        if activityType == UIActivityType.postToTwitter {
            return text + ActivityText.HASH_TAG
        }
        return text
    }
}
