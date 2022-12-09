//
//  LaunchDetailsViewController.swift
//  SpaceX
//
//  Created by Aurelian Gavrila on 15.11.2022.
//

import UIKit
import WebKit

class LaunchDetailsViewController: UIViewController {
    
    @IBOutlet private weak var webView: WKWebView!

    private let viewModel: LaunchDetailsViewModelProtocol
    
    init(viewModel: LaunchDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadWebView()
    }
    
    private func loadWebView() {
        guard let articleUrl = viewModel.launchArticleUrl, let url = URL(string: articleUrl) else { return }
        
        webView.load(URLRequest(url: url))
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        viewModel.dismissScreen()
    }
    
}
