//
//  ViewController.swift
//  Xylophone-No-Storyboard
//
//  Created by Vianney Marcellin on 2022/05/10.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    //Create a function to make a reusable button
    func noteButton(label: String, color: UIColor, margin: CGFloat) -> UIStackView {
        
        //Create the button
        let button = UIButton(type: .system)
        button.setTitle(label, for: .normal)
        button.tintColor = .white
        button.backgroundColor = color
        button.titleLabel?.font = .systemFont(ofSize: 40)
        button.addTarget(self, action: #selector(keyPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

      //Create a stackView to put different margin on each button
        let stack = UIStackView()
        
      //These two lines let you create some margin to the element in your stackView
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: margin, bottom: 0, trailing: margin)
        
        stack.addArrangedSubview(button)

        return stack
    }
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            noteButton(label: "C", color: .systemRed, margin: 5),
            noteButton(label: "D", color: .systemOrange, margin: 10),
            noteButton(label: "E", color: .systemYellow, margin: 15),
            noteButton(label: "F", color: .systemGreen, margin: 25),
            noteButton(label: "G", color: .systemIndigo, margin: 30),
            noteButton(label: "A", color: .systemBlue, margin: 35),
            noteButton(label: "B", color: .systemPurple, margin: 40)
        ])
        
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 8
        
        
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
   
        NSLayoutConstraint.activate([
            //Constraints for the vertical stackView
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
       
        ])
    }
    
    
    @objc func keyPressed(_ sender: UIButton){
        playSound(soundName: sender.currentTitle!)
        
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1.0
        }
        
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
    }
}

