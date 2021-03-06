//
//  CommentTableViewCell.swift
//  Flickr
//
//  Created by Maxim Nasakin on 29/06/16.
//  Copyright © 2016 Maxim Nasakin. All rights reserved.
//

import UIKit

final class CommentTableViewCell: UITableViewCell {
	
	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var commentLabel: UILabel!
	@IBOutlet var buddyIconImageView: UIImageView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		buddyIconImageView.alpha = 0
		buddyIconImageView.layer.cornerRadius = buddyIconImageView.frame.size.width / 2
		buddyIconImageView.clipsToBounds = true
	}
}

extension CommentTableViewCell {
	func configure(comment: Comment, row: Int) {
		nameLabel.text = comment.authorName
		commentLabel.text = comment.content
		
		tag = row
		
		buddyIconImageView.image = nil
	}
}
