//
//  RecentCallsViewController.swift
//  RogerVoice
//
//  Created by Yongjing CHEN on 14/11/2024.
//

import UIKit
import Combine
import SwiftUI

class RecentCallsViewController: UIViewController {

    @IBOutlet weak var emptyStateView: UIView!
    @IBOutlet weak var tableView: UITableView!

    var viewModel: RecentCallsViewModel! // Injected by SceneDelegate
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup tableView
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.register(RecentCallCell.self, forCellReuseIdentifier: "RecentCallCell")

        // Bind ViewModel and load calls data
        bindViewModel()
        loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Récents"
        // Do any additional setup after loading the view.
    }

    func updateViewVisibility() {
        if viewModel.calls.isEmpty {
            emptyStateView.isHidden = false
            tableView.isHidden = true
        } else {
            emptyStateView.isHidden = true
            tableView.isHidden = false
        }
    }

    // MARK: - Binding ViewModel
    private func bindViewModel() {
        // Observe changes in the `calls` property
        viewModel.$calls
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updateViewVisibility()
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }

    // MARK: - Loading Data
    private func loadData() {
        // Start loading data asynchronously
        Task {
            await viewModel.loadCalls()
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension RecentCallsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.calls.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecentCallCell", for: indexPath) as! RecentCallCell
        let call = viewModel.calls[indexPath.row]
        cell.configure(with: call)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // Get the selected call and pass it id to TranscriptionsViewModel
        let selectedCall = viewModel.calls[indexPath.row]
        let phoneNumber = selectedCall.phoneNumber // Assuming this is a property in Call
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy 'à' HH:mm"
        let timestamp = formatter.string(from: selectedCall.startDate) // Format the date as needed
        let transcriptionsViewModel = TranscriptionsViewModel(callUuid: selectedCall.id)

        // Initialize TranscriptionsView with the view model
        // bridge uikit screen to swiftui
        let transcriptionsView = UIHostingController(rootView: TranscriptionsView(
            viewModel: transcriptionsViewModel,
            phoneNumber: phoneNumber,
            timestamp: timestamp
        ))
        navigationController?.pushViewController(transcriptionsView, animated: true)
    }
}
