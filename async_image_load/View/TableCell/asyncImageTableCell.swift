//
//  asyncImageTableCell.swift
//  async_image_load
//
//  Created by Bhavesh Patel on 15/04/24.
//

import UIKit

class AsyncImageTableCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var photo : Photos? {
        didSet{
            self.configureCell()
        }
    }
    
    override func awakeFromNib() {
        imgView.contentMode = .scaleAspectFill;
    }
    
    func configureCell () {
        titleLabel.text = photo!.id
        detailLabel.text = photo!.description ?? ""
        imgView?.load(url: URL.init(string: photo!.urls.thumb)!)
    }
    
}
