//
//  LaunchesViewController.swift
//  SpaceX
//
//  Created by Aurelian Gavrila on 15.11.2022.
//

import UIKit

class LaunchesViewController: UIViewController {
    
    @IBOutlet private weak var filterButton: UIButton!
    @IBOutlet private weak var companyDescriptionLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: LaunchesViewModelProtocol
    
    init(viewModel: LaunchesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        createBindings()
        
        viewModel.getCompanyDetails()
        viewModel.getLaunchesDetails()
    }

    //MARK: - Custom Methods
    
    private func setupUI() {
        tableView.register(UINib(nibName: "LaunchTableViewCell", bundle: nil), forCellReuseIdentifier: "LaunchTableViewCellId")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func createBindings() {
        viewModel.contentLoaded = { [weak self] company in
            DispatchQueue.main.async {
                guard let company = company else {
                    self?.companyDescriptionLabel.text = "No available description"
                    return
                }
                
                self?.companyDescriptionLabel.text = "\(company.name) was founded by \(company.founder) in \(company.year). It has now \(company.numberOfEmployees) employees. \(company.launchSites) launch sites, and is valued at USD \(company.valuation)"
            }
        }
        
        viewModel.dataLoaded = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    
    private func createFilterActionSheet() {
        let actionSheetController = UIAlertController(title: "Filter Launches", message: nil, preferredStyle: .actionSheet)
        
        let yearsASC = UIAlertAction(title: "Years - ASC", style: .default) { [weak self] action in
            self?.viewModel.filterLaunchesByYear(asceding: true)
        }
        
        let yearsDSC = UIAlertAction(title: "Years - DSC", style: .default) { [weak self] action in
            self?.viewModel.filterLaunchesByYear(asceding: false)
        }
        
        let successfulLaunches = UIAlertAction(title: "Successful Launches", style: .default) { [weak self] action in
            self?.viewModel.filterLaunchesBySuccess(successful: true)
        }
        
        let failedLaunches = UIAlertAction(title: "Failed Launches", style: .default) { [weak self] action in
            self?.viewModel.filterLaunchesBySuccess(successful: false)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheetController.addAction(yearsASC)
        actionSheetController.addAction(yearsDSC)
        actionSheetController.addAction(successfulLaunches)
        actionSheetController.addAction(failedLaunches)
        actionSheetController.addAction(cancel)
        
        self.present(actionSheetController, animated: true)
    }
    
    //MARK: - IBAction Methods
    
    @IBAction func filterButtonPressed(_ sender: UIButton) {
        createFilterActionSheet()
    }
}

extension LaunchesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionsCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.launchesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchTableViewCellId", for: indexPath) as? LaunchTableViewCell else {
            return UITableViewCell()
        }

        cell.configureCellWith(viewModel.getLaunchFor(indexPath.row))
        return cell
    }
}

extension LaunchesViewController: UITableViewDelegate {
    private func createHeaderView() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        view.backgroundColor = UIColor(named: "ColorBackground")

        let label = UILabel()
        label.text = "LAUNCHES"
        label.font = UIFont(name: "HelveticaNeue-Regular", size: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.didSelectLaunchAt(indexPath.row)
    }
    
}

