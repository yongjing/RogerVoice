//
//  ParameterViewController.swift
//  RogerVoice
//
//  Created by Yongjing CHEN on 14/11/2024.
//

import UIKit

class ParameterViewController: UIViewController {
    var viewModel: RecentCallsViewModel! // Injected by SceneDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Paramètres"
    }

    @IBAction func loadCalls(_ sender: UIButton) {
        // Start loading data asynchronously
        Task {
            await viewModel.loadCalls()
        }
    }

    @IBAction func clearCalls(_ sender: UIButton) {
        viewModel.clearCalls()
    }
}
