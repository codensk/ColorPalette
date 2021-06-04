//
//  ViewController.swift
//  ColorPalette
//
//  Created by SERGEY VOROBEV on 21.05.2021.
//

import UIKit

protocol ColorPickerDelegate {
    func updateColor(selectedPicker: Picker)
}

class PickerViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var transparencyView: UIImageView!
    
    @IBOutlet weak var redColorValue: UILabel!
    @IBOutlet weak var greenColorValue: UILabel!
    @IBOutlet weak var blueColorValue: UILabel!
    
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    
    @IBOutlet weak var redValueInput: UITextField!
    @IBOutlet weak var greenValueInput: UITextField!
    @IBOutlet weak var blueValueInput: UITextField!
    
    @IBOutlet weak var alphaColorSlider: UISlider!
    
    @IBOutlet weak var doneButton: UIButton!
    
    // MARK: - Properties
    var picker: Picker!
    var delegate: ColorPickerDelegate?
    
    private let colorPreviewRadius: CGFloat = 12
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        configurePickerControls(picker: picker)
        updatePreviewColor()
    }
    
    // MARK: - Actions
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        updatePreviewColor()
    }
    
    @IBAction func doneButtonPressed() {
        delegate?.updateColor(selectedPicker: picker)
        
        dismiss(animated: true)
    }
    
    @objc private func returnKeyboardPressed() {
        view.endEditing(true)
    }
    
    // MARK: - Private Methods
    private func colorInputChanged(textField: UITextField) {
        if let textFieldValue = (textField.text as NSString?)?.floatValue {
            switch textField {
            case redValueInput:
                redColorSlider.setValue(textFieldValue, animated: true)
            case greenValueInput:
                greenColorSlider.setValue(textFieldValue, animated: true)
            case blueValueInput:
                blueColorSlider.setValue(textFieldValue, animated: true)
            default:
                break
            }
        }
        
        updatePreviewColor()
    }
    
    private func configureViews() {
        transparencyView.image = UIImage(named: "transparency")
        transparencyView.contentMode = .topLeft
        transparencyView.layer.cornerRadius = colorPreviewRadius
        
        colorView.layer.cornerRadius = colorPreviewRadius
        
        doneButton.backgroundColor = UIColor(named: "Button")
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.layer.cornerRadius = doneButton.frame.height / 2
    }
    
    private func configurePickerControls(picker: Picker) {
        let colorValueInputs = [redValueInput, greenValueInput, blueValueInput]
        var pickerRedValue: CGFloat = 0
        var pickerGreenValue: CGFloat = 0
        var pickerBlueValue: CGFloat = 0
        var pickerAlphaValue: CGFloat = 0
        
        colorValueInputs.forEach { input in
            let keyboardToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
            let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(returnKeyboardPressed))
            
            keyboardToolbar.sizeToFit()
            keyboardToolbar.barStyle = .default
            keyboardToolbar.items = [flexBarButton, doneBarButton]
            
            input?.inputAccessoryView = keyboardToolbar
            input?.textAlignment = .center
            
            input?.delegate = self
        }
        
        picker.color.getRed(&pickerRedValue, green: &pickerGreenValue, blue: &pickerBlueValue, alpha: &pickerAlphaValue)

        redColorSlider.minimumTrackTintColor = .systemRed
        redColorSlider.thumbTintColor = .systemRed
        redColorSlider.setValue(Float(pickerRedValue), animated: true)
        
        greenColorSlider.minimumTrackTintColor = .systemGreen
        greenColorSlider.thumbTintColor = .systemGreen
        greenColorSlider.setValue(Float(pickerGreenValue), animated: true)
        
        blueColorSlider.minimumTrackTintColor = .systemBlue
        blueColorSlider.thumbTintColor = .systemBlue
        blueColorSlider.setValue(Float(pickerBlueValue), animated: true)
        
        alphaColorSlider.minimumTrackTintColor = .systemGray
        alphaColorSlider.thumbTintColor = .systemGray
        alphaColorSlider.minimumValueImage = UIImage(named: "alpha0")
        alphaColorSlider.maximumValueImage = UIImage(named: "alpha1")
        alphaColorSlider.setValue(Float(pickerAlphaValue), animated: true)
    }
    
    
    private func updatePreviewColor() {
        let redValue = CGFloat(redColorSlider.value)
        let greenValue = CGFloat(greenColorSlider.value)
        let blueValue = CGFloat(blueColorSlider.value)
        let alphaValue = CGFloat(alphaColorSlider.value)
        let selectedColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: alphaValue)
        
        colorView.backgroundColor = selectedColor
        
        redColorValue.text = String(format: "%.2f", redColorSlider.value)
        greenColorValue.text = String(format: "%.2f", greenColorSlider.value)
        blueColorValue.text = String(format: "%.2f", blueColorSlider.value)
        
        redValueInput.text = String(format: "%.2f", redColorSlider.value)
        greenValueInput.text = String(format: "%.2f", greenColorSlider.value)
        blueValueInput.text = String(format: "%.2f", blueColorSlider.value)
        
        colorView.alpha = CGFloat(alphaColorSlider.value)
        
        // set current Picker color
        picker = Picker(color: selectedColor)
    }
    
}

// MARK: - Extensions
extension PickerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        colorInputChanged(textField: textField)
        
        view.endEditing(true)
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        colorInputChanged(textField: textField)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
