//
//  RJChooseImageCCell.swift
//  SenseGo
//
//  Created by Shen Ruijie on 2020/6/5.
//  Copyright © 2020 Sensetime. All rights reserved.
//

import UIKit

class RJChooseImageCCell: RJImageCCell, YBImageBrowserDelegate, YBImageBrowserDataSource {
    var imageBrowser:YBImageBrowser?
    
    var image:Any?{
        didSet{
            switch image {
                case let image as String:
                    imageView.sd_setImage(with: image.url, placeholderImage: kplaceholderImage)
                case let image as UIImage:
                    imageView.image = image
                default:
                break
            }
        }
    }
    
    lazy var chooseBtn:UIButton = {
        let button = self.contentView.addButton(with: fontSize(16), title: nil, titleColor: UIColor.white, image: nil)!
        button.setImage(imageNamed("single_unselected"), for: .normal)
        button.setImage(imageNamed("single_selected"), for: .selected)
        button.addWidthConstraint(withConstant: 30, heightConstraintWithConstant: 30)
//        button.addTarget(self, action: #selector(chooseAction), for: .touchUpInside)
        return button
    }()
    
    
    
    // MARK: - Function
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        contentView.addTopAlignConstraint(to: chooseBtn, constant: 0)
        contentView.addRightAlignConstraint(to: chooseBtn, constant: 0)
        self.imageView.layer.cornerRadius = 5
        self.imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init { [weak self](obj) in
            self?.imageBrowser = YBImageBrowser()
            self?.imageBrowser?.delegate = self
            self?.imageBrowser?.dataSource = self
//            self?.imageBrowser?.currentPage = index
            //   ?             self.imageBrowser.inheritedAnimationDuration = 0.2;
            self?.imageBrowser?.show()
        }
        self.imageView.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    @objc func chooseAction(){
//        chooseBtn.isSelected = !chooseBtn.isSelected
//    }
    //MARK: - YBImageBrowserDataSource
    func yb_numberOfCells(in imageBrowser: YBImageBrowser) -> Int {
        return 1
    }
    
    func yb_imageBrowser(_ imageBrowser: YBImageBrowser, dataForCellAt index: Int) -> YBIBDataProtocol {
        let data = YBIBImageData()
        
        data.thumbImage = imageView.image
        data.image = {[weak self] in
            return self?.imageView.image
        };
        return data
    }
    
}
