//
//  FacilityTableViewCell.swift
//  iFacility
//
//  Created by Jameel Shehadeh on 29/06/2023.
//

import UIKit
import SnapKit

protocol FacilityTableViewCellDelegate : AnyObject {
    func didSelectOption(option: Option)
}

class FacilityTableViewCell: UITableViewCell {
    
    var model : Facility?
    
    weak var delegate : FacilityTableViewCellDelegate?
    
    private lazy var vStackView : UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [facilityNameLabel,optionsCollectionView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = .init(top: 10, leading: 20, bottom: 10, trailing: 20)
        return stackView
    }()
    
    private lazy var facilityNameLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    private lazy var optionsCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0 , bottom: 0, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        let collectionView = UICollectionView(frame: .null, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(FacilityOptionCollectionViewCell.self, forCellWithReuseIdentifier: "FacilityOptionCollectionViewCell")
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        updateUI()
    }

    private func updateUI(){
        contentView.addSubview(vStackView)
    }
    
    func setupCell(model facility: Facility){
        self.model = facility
        facilityNameLabel.text = facility.name
        optionsCollectionView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        facilityNameLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FacilityTableViewCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model?.options?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilityOptionCollectionViewCell", for: indexPath) as? FacilityOptionCollectionViewCell , let optionModel = model?.options?[indexPath.item] else {return UICollectionViewCell()}
        cell.cellSetup(model: optionModel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let option = model?.options?[indexPath.item] else {return}
        delegate?.didSelectOption(option: option)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = model?.options?[indexPath.item].name ?? ""
        return CGSize(width: text.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)]).width + 40 + 20, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
