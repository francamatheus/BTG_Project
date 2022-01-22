//
//  CustomAlertViewController.swift
//  desafio-ios-matheus-frança
//
//  Created by matheus.s.franca on 29/06/20.
//  Copyright © 2020 matheus.s.franca. All rights reserved.
//

import UIKit

class CustomAlertViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    var titleText: String?
    var descriptionText: String?
    var firstButtonText: String?
    var secondButtonText: String?
    var firstButtonAction: (() -> Void)?
    var secondButtonAction: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupButtons()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         let touch = touches.first
         if touch?.view == self.view {
            dismiss()
        }
    }
    
    convenience init(title: String,
                     description: String,
                     firstButtonText: String,
                     secondButtonText: String? = nil,
                     firstButtonAction: @escaping () -> Void,
                     secondButtonAction:  (() -> Void)? = {}
    ) {
        self.init()
        self.titleText = title
        self.descriptionText = description
        self.firstButtonText = firstButtonText
        self.secondButtonText = secondButtonText
        self.firstButtonAction = firstButtonAction
        self.secondButtonAction = secondButtonAction
    }
    
    func setupView() {
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 10
        
        self.view.isOpaque = false
        self.view.backgroundColor = UIColor.clear
        
        self.titleLabel.numberOfLines = 2
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        self.titleLabel.text = titleText
        self.titleLabel.textAlignment = .center
        
        self.descriptionLabel.text = descriptionText
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.textAlignment = .center
        
    }
    
    func setupButtons() {
        
        firstButton.backgroundColor = .red
        firstButton.tintColor = .white
        firstButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        secondButton.layer.borderWidth = 1
        secondButton.layer.borderColor = UIColor.black.cgColor
        secondButton.tintColor = .black
        secondButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        firstButton.setTitle(self.firstButtonText, for: .normal)
        secondButton.setTitle(self.secondButtonText, for: .normal)
        
        if secondButtonText == nil {
            secondButton.isHidden = true
        }
    }
    
    @IBAction func firstButtonAction(_ sender: Any) {
        dismiss()
    }
    
    @IBAction func secondButtonAction(_ sender: Any) {
        dismiss()
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
