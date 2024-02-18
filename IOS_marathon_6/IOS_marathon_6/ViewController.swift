//
//  ViewController.swift
//  IOS_marathon_6
//
//  Created by Наталья Коновалова on 18.02.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    private let squareView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemBlue
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }
    
    private func setupInitialState() {
        addActions()
        setupFrame()
        addSubviews()
    }
    
    private func addActions() {
        let gestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(tapOnViewAction(sender: ))
        )
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    private func setupFrame() {
        squareView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        squareView.center = view.center
    }
    
    private func addSubviews() {
        view.addSubview(squareView)
    }
    
    private func calculateAngle(_ condition: (Bool, Bool)) -> Double {
        switch condition {
        case (true, true), (false, false):
            return -0.4
        case (true, false), (false, true):
            return 0.4
        }
    }
    
    private func randomColor() -> UIColor {
        return UIColor(red: Double.random(in: 0.3...1),
                       green: Double.random(in: 0.3...1),
                       blue:Double.random(in: 0.3...1),
                       alpha: 1.0)
    }
    
    @objc private func tapOnViewAction(sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        let condition = (location.x >= squareView.center.x, location.y >= squareView.center.y)
        let rotationAngle = calculateAngle(condition)
        let color = self.randomColor()
        
        squareView.transform = CGAffineTransform(rotationAngle: rotationAngle)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3) {
            self.squareView.transform = .identity
            self.squareView.center = location
            self.squareView.backgroundColor = color
        }
    }
}
