//
//  AddItemViewController.swift
//  MediaManager
//
//  Created by Benjamin Prentiss on 1/9/23.
//

import UIKit

class AddItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //Mark: Outlets
    @IBOutlet weak var movieCheckboxButton: UIButton!
    @IBOutlet weak var tvShowCheckboxButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var yearPicker: UIPickerView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet weak var isFavoriteSegmentedControl: UISegmentedControl!
    @IBOutlet weak var wasWatchedSegmentedControl: UISegmentedControl!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //Mark: Properties
    var yearPickerValue = Calendar.current.component(.year, from: Date())
      var isMovie = true
      var ratingValue = 10.0
      var isFavorite = true
      var wasWatched = true
    
    //Mark: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.yearPicker.delegate = self
        self.yearPicker.dataSource = self
        self.tvShowCheckboxButton.imageView?.image = UIImage(systemName: "square")
    }
    
    //Mark: Delegate Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let currentYear = Calendar.current.component(.year, from: Date())
             return currentYear - 1799
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          let year = Calendar.current.component(.year, from: Date()) - row
          return String(year)
       }

       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          yearPickerValue = Calendar.current.component(.year, from: Date()) - row
       }
    
    //Mark: Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text,
              let mediaType = isMovie ? "Movie" : "TV Show",
              let itemDescription = descriptionTextView.text else { return }
        
        MediaItemController.shared.createMediaItem(title: title, mediaType: mediaType, year: yearPickerValue, itemDescription: itemDescription, rating: ratingValue, wasWatched: wasWatched, isFavorite: isFavorite)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func movieCheckboxButtonTapped(_ sender: Any) {
        self.movieCheckboxButton.imageView?.image = UIImage(systemName: "checkmark.square")
        self.tvShowCheckboxButton.imageView?.image = UIImage(systemName: "square")
        self.isMovie = true
    }
    
    @IBAction func tvShowCheckedButtonTapped(_ sender: Any) {
        self.movieCheckboxButton.imageView?.image = UIImage(systemName: "square")
        self.tvShowCheckboxButton.imageView?.image = UIImage(systemName: "checkmark.square")
        self.isMovie = false
    }
    
    @IBAction func ratingSliderChanged(_ sender: UISlider) {
        let roundedValue = Double(sender.value).roundTo(places: 1)
        ratingValue = roundedValue
        ratingLabel.text = "Rating: \(ratingValue)"
    }
    
    @IBAction func isFavoriteSegmentedControlSwitched(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            isFavorite = true
        } else {
            isFavorite = false
        }
    }
    
    @IBAction func wasWatchedSegmentedControlSwitched(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            wasWatched = true
        } else {
            wasWatched = false
        }
    }
}

extension Double {
   func roundTo(places:Int) -> Double {
      let divisor = pow(10.0, Double(places))
      return (self * divisor).rounded() / divisor
   }
}
