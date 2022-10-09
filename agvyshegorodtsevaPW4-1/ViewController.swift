//
//  ViewController.swift
//  agvyshegorodtsevaPW2-1
//
//  Created by Алиса Вышегородцева on 23.09.2022.
//

import UIKit


final class WelcomeViewController: UIViewController {
    let notesView = NotesViewController()
    let colorPaletteView = ColorPaletteView()
    var colorHidden: Bool = true
    private let commentLabel = UILabel()
    var commentView = UIView()
    private let valueLabel = UILabel()
    private var value: Int = 0
    let incrementButton = UIButton()
    
    var colorsButton = UIButton()
    var notesButton = UIButton()
    var newsButton = UIButton()
    
    var buttonsSV = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupMenuButtons()
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
        view.addSubview(setupCommentView())
        setupIncrementButton()
        setupValueLabel()
        commentView.isHidden = true
        colorPaletteView.isHidden = true
        setupMenuButtons()
        setupColorControlSV()
    }
    
    
    private func makeMenuButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16.0,
                                              weight: .medium)
        button.backgroundColor = .white
        button.layer.applyShadow()
        button.heightAnchor.constraint(equalTo: button.widthAnchor)
            .isActive = true
        return button
    }
    
    private func setupMenuButtons() {
        colorsButton = makeMenuButton(title: "🎨")
        colorsButton.addTarget(self, action: #selector(paletteButtonPressed), for: .touchUpInside)
        
        notesButton = makeMenuButton(title: "📔")
        notesButton.addTarget(self, action: #selector(notesButtonPressed), for: .touchUpInside)
        
        newsButton = makeMenuButton(title: "📑")
        
        buttonsSV = UIStackView(arrangedSubviews:
                                    [colorsButton, notesButton, newsButton])
        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually
        self.view.addSubview(buttonsSV)
        buttonsSV.pin(to: self.view, [.left: 24, .right: 24])
        buttonsSV.pinBottom(to:
                                self.view.safeAreaLayoutGuide.bottomAnchor, 24)
    }
    
    private func setupColorControlSV() {
        colorPaletteView.isHidden = true
        view.addSubview(colorPaletteView)
        colorPaletteView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorPaletteView.topAnchor.constraint(equalTo:
                                                    incrementButton.bottomAnchor, constant: 8),
            colorPaletteView.leadingAnchor.constraint(equalTo:
                                                        view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            colorPaletteView.trailingAnchor.constraint(equalTo:
                                                        view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            colorPaletteView.bottomAnchor.constraint(equalTo:
                                                        buttonsSV.topAnchor, constant: -8)
        ])
    }
    
    @objc
    private func paletteButtonPressed() {
        colorPaletteView.isHidden.toggle()
        colorHidden.toggle()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        self.view.backgroundColor = colorPaletteView.chosenColor
        colorPaletteView.addTarget(self, action:
                                    #selector(changeColor(_:)), for: .touchDragInside)
        
    }
    
    @objc
    private func changeColor(_ slider: ColorPaletteView) {
        UIView.animate(withDuration: 1) {
            self.view.backgroundColor = slider.chosenColor
        }
    }
    
    private func setupIncrementButton() {
        incrementButton.setTitle("Increment", for: .normal)
        incrementButton.setTitleColor(.black, for: .normal)
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font = .systemFont(ofSize:
                                                        16.0, weight: .medium)
        incrementButton.backgroundColor = .white
        incrementButton.layer.applyShadow()
        self.view.addSubview(incrementButton)
        incrementButton.setHeight(to: 48)
        incrementButton.pinTop(to: self.view.centerYAnchor)
        incrementButton.pin(to: self.view, [.left: 24, .right: 24])
        incrementButton.addTarget(self, action:
                                    #selector(incrementButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func incrementButtonPressed() {
        value += 1
        commentView.isHidden=false
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        UIView.animate(withDuration: 1) {
            self.updateUI()
        }
        
    }
    
    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40.0,
                                      weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "\(value)"
        self.view.addSubview(valueLabel)
        valueLabel.pinBottom(to: incrementButton.topAnchor, 16)
        valueLabel.pinCenter(to: self.view.centerXAnchor)
    }
    
    
    private func updateUI() {
        valueLabel.text = "\(value)"
        updateCommentLabel(value: value)
    }
    
    
    private func setupCommentView() -> UIView {
        commentView.backgroundColor = .white
        commentView.layer.cornerRadius = 12
        view.addSubview(commentView)
        commentView.pinTop(to:
                            self.view.safeAreaLayoutGuide.topAnchor)
        commentView.pin(to: self.view, [.left: 24, .right: 24])
        commentLabel.font = .systemFont(ofSize: 14.0,
                                        weight: .regular)
        commentLabel.textColor = .systemGray
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        commentView.addSubview(commentLabel)
        commentLabel.pin(to: commentView, [.top: 16, .left:
                                            16, .bottom: 16, .right: 16])
        return commentView
    }
    
    func updateCommentLabel(value: Int) {
        switch value {
        case 0...10:
            commentLabel.text = "oh yeah yeah keep tapping"
        case 10...20:
            commentLabel.text = "and more and more"
        case 20...30:
            commentLabel.text = "way to go!!!"
        case 30...40:
            commentLabel.text = "oh yeah big numbers here"
        case 40...50:
            commentLabel.text = "damn more than 40 times keep going"
        case 50...60:
            commentLabel.text = "big boy!!"
        case 60...70:
            commentLabel.text = "you will see stars if you tap 10 more times"
        case 70...80:
            commentLabel.text = "⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐"
        case 80...90:
            commentLabel.text = "80+\n go higher!"
        case 90...100:
            commentLabel.text = "90!! here are hearts for you ❤️❤️❤️"
        default:
            break
        }
    }
    @objc
    private func notesButtonPressed() {
        let navigation = UINavigationController(rootViewController: notesView)
        present(navigation, animated: true)
    }
}
