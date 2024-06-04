//
//  ViewController.swift
//  ElementsLearning
//
//  Created by Egor on 23.04.24.
//

import UIKit

class ViewController: UIViewController {
    
    var uiElements = ["UISegmentedControl",
                      "UILabel",
                      "UISlider",
                      "UITextField",
                      "UIButton",
                      "UIDatePicker"]
    
    var selectedElement: String?
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var lable: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var datePiker: UIDatePicker!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var switchLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.value = 1
        
        lable.text = String(slider.value)
        lable.font = lable.font.withSize(35)
        lable.textAlignment = .center
        lable.numberOfLines = 2
        
        segmentedControl.insertSegment(withTitle: "Third", at: 2, animated: true)
        
        slider.minimumValue = 0
        slider.maximumValue = 1
        
        datePiker.locale = Locale(identifier: "ru_RU")
        
        choiceUiElement()
        createToolBar()
    }
    
    func hideAllElements() {
        segmentedControl.isHidden = true
        lable.isHidden = true
        slider.isHidden = true
        doneButton.isHidden = true
        datePiker.isHidden = true
    }
    
    func choiceUiElement() {
        let elementPicker = UIPickerView()
        elementPicker.delegate = self
        textField.inputView = elementPicker
        
        //Costamization
        elementPicker.backgroundColor = .blue
    }
    
    func createToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: self,
                                         action: #selector(dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolBar
        
        //Costamization
        toolBar.tintColor = .white
        toolBar.barTintColor = .blue
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func choiceSegment(_ sender: UISegmentedControl) {
        
        lable.isHidden = false
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            lable.text = "The first sigment is selected"
            lable.textColor = .red
        case 1:
            lable.text = "The second sigment is selected"
            lable.textColor = .blue
        case 2:
            lable.text = "The third sigment is selected"
            lable.textColor = .yellow
        default:
            print("Something wrong!")
        }
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        lable.text = String(sender.value)
        
        let backgraundColor = self.view.backgroundColor
        self.view.backgroundColor = backgraundColor?.withAlphaComponent(CGFloat(sender.value))
    }
 
    @IBAction func donePassed(_ sender: UIButton) {
        guard textField.text?.isEmpty == false else { return }
        
        if let _ = Double(textField.text!) {
            let alert = UIAlertController(title: "Wrong format", message: "Please enter your name", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
            print("Name format is wrong")
        } else {
            lable.text = textField.text
            textField.text = nil
        }
    }
    
    @IBAction func changeDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let dateValue = dateFormatter.string(from: sender.date)
        
        lable.text = dateValue
    }
    
    
    @IBAction func switchAction(_ sender: UISwitch) {
        segmentedControl.isHidden = !segmentedControl.isHidden
        lable.isHidden = !lable.isHidden
        slider.isHidden = !slider.isHidden
        datePiker.isHidden = !datePiker.isHidden
        doneButton.isHidden = !doneButton.isHidden
        
        if sender.isOn {
            switchLable.text = "Отобразить все элементы"
        } else {
            switchLable.text = "Скрыть все элементы"
        }
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return uiElements.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return uiElements[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedElement = uiElements[row]
        textField.text = selectedElement
        
        switch row {
        case 0:
            hideAllElements()
            segmentedControl.isHidden = false
        case 1:
            hideAllElements()
            lable.isHidden = false
        case 2:
            hideAllElements()
            slider.isHidden = false
        case 3:
            hideAllElements()
        case 4:
            hideAllElements()
            doneButton.isHidden = false
        case 5:
            hideAllElements()
            datePiker.isHidden = false
        default:
            hideAllElements()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, 
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {
        
        var pickerViewLable = UILabel()
        if let currentLable = view as? UILabel {
            pickerViewLable = currentLable
        } else {
            pickerViewLable = UILabel()
        }
        
        pickerViewLable.textColor = .white
        pickerViewLable.textAlignment = .center
        pickerViewLable.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 23)
        pickerViewLable.text = uiElements[row]
        
        return pickerViewLable
    }
    
}
