//
//  ViewController.swift
//  iFacility
//
//  Created by Jameel Shehadeh on 28/06/2023.
//

import UIKit

class FacilitiesVC: UIViewController , Alertable {

    var viewModel : FacilitiesViewModel
    
    private let refreshControl = UIRefreshControl()
    
    private lazy var tableView : UITableView = {
       let tableView = UITableView()
        tableView.register(FacilityTableViewCell.self, forCellReuseIdentifier: "FacilityTableViewCell")
        tableView.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.rowHeight = 100
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        bindData()
        viewModel.fetchFacilities()
        refreshControl.addTarget(self, action: #selector(reloadPage), for: .valueChanged)
        tableView.refreshControl = refreshControl
        self.refreshControl.beginRefreshing()
    }
    
    func bindData(){
        
        viewModel.didUpdateFacilities = { [weak self] in
            guard let self else {return}
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        
        viewModel.showAlert = { [weak self] alertMessage in
            guard let self else {return}
            showAlert(title: "Error", message: alertMessage, preferredStyle: .alert, completion: nil)
        }
        
    }
    
    @objc func reloadPage(){
        viewModel.fetchFacilities()
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
    
    func didSelectOption(option: Option,facilityId: String) {
        viewModel.selectOption(option: option,facilityId: facilityId)
    }
    
}
