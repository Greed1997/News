//
//  DescriptionViewController.swift
//  News
//
//  Created by Александр on 05.02.2023.
//

import UIKit
import WebKit
protocol DescriptionViewControllerProtocol {
    func setView(title: String?, imageURL: String?, description: String?, publishedAt: String?, fullInfotURL: String?)
}
class DescriptionViewController: UIViewController, WKNavigationDelegate {
   
    var delegate: DescriptionViewControllerProtocol!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: NewsImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var publishedAt: UILabel!
    @IBOutlet weak var fullInfoURL: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
extension DescriptionViewController: DescriptionViewControllerProtocol {
    func setView(title: String?, imageURL: String?, description: String?, publishedAt: String?, fullInfotURL: String?) {
        self.publishedAt.text = publishedAt
        self.imageView.fetchImage(from: imageURL)
        self.descriptionLabel.text = description
        self.titleLabel.text = title
        guard let fullInfotURL = fullInfotURL else { return }
        guard let url = URL(string: fullInfotURL) else { return }
        self.fullInfoURL.load(URLRequest(url: url))
        
    }
    
    
}
