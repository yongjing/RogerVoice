//
//  RecentCallCell.swift
//  RogerVoice
//
//  Created by Yongjing CHEN on 14/11/2024.
//

import UIKit

class RecentCallCell: UITableViewCell {
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var statusIconImageView: UIImageView!
    @IBOutlet weak var interlocutorIconImageView: UIImageView!

    func configure(with call: Call) {
        phoneNumberLabel.text = call.phoneNumber
        dateTimeLabel.text = formatDate(call.startDate)
        interlocutorIconImageView.isHidden = true
        isUserInteractionEnabled = false

        switch call.direction {
        case .outgoing:
            statusIconImageView.image = UIImage(named: "outgoing")
        case .incoming:
            statusIconImageView.image = UIImage(named: "incoming")
        }
        switch call.status {
        case .success:
            interlocutorIconImageView.isHidden = false
            isUserInteractionEnabled = true
        case .missed:
            statusIconImageView.image = UIImage(named: "cross_close_little")
        case .rejected:
            statusIconImageView.image = UIImage(named: "cross_close_little")
        case .notReached:
            statusIconImageView.image = UIImage(named: "cross_close_little")
        }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy, HH:mm"
        return formatter.string(from: date)
    }
}
