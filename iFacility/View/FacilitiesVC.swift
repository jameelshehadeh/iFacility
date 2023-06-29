//
//  ViewController.swift
//  iFacility
//
//  Created by Jameel Shehadeh on 28/06/2023.
//

import UIKit

class FacilitiesVC: UIViewController {

    var viewModel : FacilitiesViewModel
    
    private lazy var tableView : UITableView = {
       let tableView = UITableView()
        tableView.register(FacilityTableViewCell.self, forCellReuseIdentifier: "FacilityTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        viewModel.fetchFacilities()
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
    
    func bindData(){
        
        viewModel.didUpdateFacilities = { [weak self] in
            guard let self else {return}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel.didUpdateExclusions = { [weak self] in
            guard let self else {return}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    init(viewModel: FacilitiesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FacilitiesVC : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfFacilities
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FacilityTableViewCell") as? FacilityTableViewCell else {return UITableViewCell()}
        cell.setupCell(model: viewModel.facility(at: indexPath.row))
        cell.delegate = self
        return cell
    }
    
}

extension FacilitiesVC : FacilityTableViewCellDelegate {
    func didSelectOption(option: Option) {
        
    }
}
