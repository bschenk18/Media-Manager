//
//  EditItemViewController.swift
//  MediaManager
//
//  Created by Benjamin Prentiss on 1/11/23.
//

import UIKit

protocol EditDetailDelegate: AnyObject {
    func mediaItemEdited(title: String, rating: Double, year: Int, description: String)
}

class EditItemViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet weak var releaseYearTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    weak var delegate: EditDetailDelegate?
    var mediaItem: MediaItem?
    var ratingValue = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        guard let mediaItem = mediaItem else {
            return
        }
        
        self.titleTextField.text = mediaItem.title
        self.ratingLabel.text = "Rating: \(mediaItem.rating)"
        self.ratingSlider.value = Float(mediaItem.rating)
        self.descriptionTextView.text = mediaItem.itemDescription
        self.ratingValue = mediaItem.rating
        self.releaseYearTextField.keyboardType = .numberPad
        self.releaseYearTextField.text = String(mediaItem.year)
    }
    
    @IBAction func ratingSliderAdjusted(_ sender: UISlider) {
        let roundedValue = Double(sender.value).roundTo(places: 1)
        if roundedValue != ratingValue {
            ratingValue = roundedValue
            ratingLabel.text = "Rating: \(ratingValue)"
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        guard let delegate = self.delegate,
              let year = self.releaseYearTextField.text,
              let title = self.titleTextField.text,
              let description = self.descriptionTextView.text else { return }
        if let year = Int(year) {
            delegate.mediaItemEdited(title: title, rating: ratingValue, year: year, description: description)
            self.navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Uh oh!", message: "You have an invalid year. Please correct it.", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(dismissAction)
            present(alert, animated: true)
        }
    }
}
