//
//  HomeViewController.swift
//  ColorPalette
//
//  Created by SERGEY VOROBEV on 04.06.2021.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - Properties
    var picker = Picker()
    
    private var colorView: UIView!

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureColorView()
    }
    
    // MARK: - Actions
    @objc private func colorPicketButtonPressed() {
        guard let pickerVC = storyboard?.instantiateViewController(identifier: "colorPickerVC") as? PickerViewController else { return }
        
        pickerVC.modalPresentationStyle = .fullScreen
        pickerVC.picker = picker
        pickerVC.delegate = self
        
        present(pickerVC, animated: true)
    }

    // MARK: - Methods
    private func configureNavigationBar() {
        let colorPickerButton = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(colorPicketButtonPressed))
        
        navigationItem.rightBarButtonItem = colorPickerButton
    }
    
    private func configureColorView() {
        colorView = UIView(frame: view.frame)

        view.addSubview(colorView)
        
        updateViewBackground(color: picker.color)
    }
    
    private func updateViewBackground(color: UIColor) {
        colorView.backgroundColor = color
    }

}

// MARK: - Extensions
extension HomeViewController: ColorPickerDelegate {
    func updateColor(selectedPicker: Picker) {
        picker = selectedPicker
        
        updateViewBackground(color: picker.color)
    }
}
