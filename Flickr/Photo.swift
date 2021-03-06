//
//  Photo.swift
//  Flickr
//
//  Created by Maxim Nasakin on 20/06/16.
//  Copyright © 2016 Maxim Nasakin. All rights reserved.
//

import Foundation

struct Photo {
	let photoID: String
	let title: String
	
	let smallImageURL: NSURL
	let largeImageURL: NSURL?
	
	let ownerID: String
}

extension Photo {
	init?(dictionary: JSONDictionary) {
		guard let
			photoID = dictionary["id"] as? String,
			title = dictionary["title"] as? String,
			smallImageURLString = dictionary["url_m"] as? String,
			ownerID = dictionary["owner"] as? String,
			smallImageURL = NSURL(string: smallImageURLString) else {
				return nil
		}
		
		let hugeImageURLString = dictionary["url_h"] as? String
		let mediumImageURLString = dictionary["url_z"] as? String
		
		let largeImageURLString = hugeImageURLString ?? mediumImageURLString
		
		if let urlString = largeImageURLString, url = NSURL(string: urlString) {
			self.largeImageURL = url
		} else {
			self.largeImageURL = nil
		}
		
		self.photoID = photoID
		self.title = title
		self.smallImageURL = smallImageURL
		self.ownerID = ownerID
	}
}

extension Photo {
	static func all(url: NSURL) -> Resource<[Photo]> {
		return Resource<[Photo]>(url: url) { json in
			guard let
				jsonPhotos = json["photos"] as? JSONDictionary,
				dictionaries = jsonPhotos["photo"] as? [JSONDictionary] else { return nil }
			return dictionaries.flatMap(Photo.init)
		}
	}
}

extension Photo: Equatable {}

func ==(lhs: Photo, rhs: Photo) -> Bool {
	return lhs.photoID == rhs.photoID
}
