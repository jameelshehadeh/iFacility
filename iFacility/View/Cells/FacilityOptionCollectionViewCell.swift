//
//  FacilityOptionCollectionViewCell.swift
//  iFacility
//
//  Created by Jameel Shehadeh on 29/06/2023.
//

import UIKit

class FacilityOptionCollectionViewCell: UICollectionViewCell {
    
    lazy var containerView : UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        containerView.layer.cornerRadius = 15
        containerView.clipsToBounds = true
        return containerView
    }()
    
    private lazy var hStackView : UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [optionLabel,optionImage])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.distribution = .fill
        return stackView
    }()
    
    let optionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .darkGray
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    private lazy var optionImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = false
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.greaterThanOrEqualTo(50)
        }
        
        containerView.addSubview(hStackView)
        hStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }

    }
    
    func cellSetup(model : Option){
        optionLabel.text = model.name
        optionImage.image = UIImage(named: "\(model.icon)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
