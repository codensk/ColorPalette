//
//  ViewController.swift
//  ColorPalette
//
//  Created by SERGEY VOROBEV on 21.05.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var transparencyView: UIImageView!
    
    @IBOutlet weak var redColorValue: UILabel!
    @IBOutlet weak var greenColorValue: UILabel!
    @IBOutlet weak var blueColorValue: UILabel!
    
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!

    @IBOutlet weak var alphaColorSlider: UISlider!
    
    // MARK: - Private Properties
    private let colorPreviewRadius: CGFloat = 12
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        configureSliders()
        updatePreviewColor()
    }
    
    // MARK: - IBActions
    @IBAction func redSlider(_ sender: UISlider) {
        redColorValue.text = String(format: "%.2f", redColorSlider.value)
        
        updatePreviewColor()
    }
    
    @IBAction func greenSlider(_ sender: UISlider) {
        greenColorValue.text = String(format: "%.2f", greenColorSlider.value)
        
        updatePreviewColor()
    }
    
    @IBAction func blueSlider(_ sender: UISlider) {
        blueColorValue.text = String(format: "%.2f", blueColorSlider.value)
        
        updatePreviewColor()
    }
    
    @IBAction func alphaSlider(_ sender: UISlider) {
        colorView.alpha = CGFloat(alphaColorSlider.value)
        
        updatePreviewColor()
    }
    

    // MARK: - Private Methods
    private func configureViews() {
        transparencyView.image = UIImage(named: "transparency")
        transparencyView.contentMode = .topLeft
        transparencyView.layer.cornerRadius = colorPreviewRadius
        
        colorView.layer.cornerRadius = colorPreviewRadius
    }
    
    private func configureSliders() {
        redColorSlider.minimumTrackTintColor = .systemRed
        redColorSlider.thumbTintColor = .systemRed
        
        greenColorSlider.minimumTrackTintColor = .systemGreen
        greenColorSlider.thumbTintColor = .systemGreen
        
        blueColorSlider.minimumTrackTintColor = .systemBlue
        blueColorSlider.thumbTintColor = .systemBlue
        
        alphaColorSlider.minimumTrackTintColor = .systemGray
        alphaColorSlider.thumbTintColor = .systemGray
        alphaColorSlider.minimumValueImage = UIImage(named: "alpha0")
        alphaColorSlider.maximumValueImage = UIImage(named: "alpha1")
    }
    
    private func updatePreviewColor() {
        let redValue = CGFloat(redColorSlider.value)
        let greenValue = CGFloat(greenColorSlider.value)
        let blueValue = CGFloat(blueColorSlider.value)
        let alphaValue = CGFloat(alphaColorSlider.value)
        
        colorView.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: alphaValue)
    }

}

