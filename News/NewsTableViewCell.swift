//
//  NewsTableViewCell.swift
//  News
//
//  Created by Александр on 05.02.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: NewsImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    
    override var reuseIdentifier: String? {
        "NewsTableViewCell"
    }
    
    func configure(title: String?, imageURL: String?) {
        guard newsImageView != nil else { return }
        guard newsTitleLabel != nil else { return }

        newsImageView.fetchImage(from: imageURL)
        newsTitleLabel.text = title
    }
}

