//
//  DatePickerViewController.swift
//  MediaManager
//
//  Created by Benjamin Prentiss on 1/12/23.
//

import UIKit

protocol DatePickerDelegate: AnyObject {
    func reminderDateEdited(date: Date)
}

class DatePickerViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: - Properties
    var date: Date?
    weak var delegate: DatePickerDelegate?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    
    // MARK: - Methods
    func setupViews() {
        self.datePicker.preferredDatePickerStyle = .wheels
    }
    
    // MARK: - Actions
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        self.date = sender.date
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let delegate = delegate,
              let date = self.date else { return }
        delegate.reminderDateEdited(date: date)
        navigationController?.popViewController(animated: true)
    }
}
