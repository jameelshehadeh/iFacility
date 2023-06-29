//
//  ViewController.swift
//  iFacility
//
//  Created by Jameel Shehadeh on 28/06/2023.
//

import UIKit

class ViewController: UIViewController {

    var viewModel : FacilitiesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchFacilities()
    }
    
    init(viewModel: FacilitiesViewModel? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
