//
//  ViewController.swift
//  CatchTheFruits
//
//  Created by Halil Özel on 13.12.2018.
//  Copyright © 2018 Halil Özel. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var highscoreLabel: UILabel!

    @IBOutlet private weak var fruit1: UIImageView!
    @IBOutlet private weak var fruit2: UIImageView!
    @IBOutlet private weak var fruit3: UIImageView!
    @IBOutlet private weak var fruit4: UIImageView!
    @IBOutlet private weak var fruit5: UIImageView!
    @IBOutlet private weak var fruit6: UIImageView!
    @IBOutlet private weak var fruit7: UIImageView!
    @IBOutlet private weak var fruit8: UIImageView!
    @IBOutlet private weak var fruit9: UIImageView!

    private let highScoreKey = "highscore"
    private static let gameDuration = 20
    private let fruitHideInterval: TimeInterval = 0.5

    private var score = 0
    private var counter = Self.gameDuration
    private var timer: Timer?
    private var hideTimer: Timer?
    private var fruitsArray: [UIImageView] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        fruitsArray = [fruit1, fruit2, fruit3, fruit4, fruit5, fruit6, fruit7, fruit8, fruit9]
        configureGestures()
        updateHighScoreLabel()
        startGame()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimers()
    }

    private func configureGestures() {
        for fruit in fruitsArray {
            fruit.isUserInteractionEnabled = true
            fruit.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(increaseScore)))
        }
    }

    private func startGame() {
        stopTimers()

        score = 0
        counter = Self.gameDuration
        scoreLabel.text = "Score : \(score)"
        timeLabel.text = "Time : \(counter)"

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.countDown()
        }

        hideTimer = Timer.scheduledTimer(withTimeInterval: fruitHideInterval, repeats: true) { [weak self] _ in
            self?.hideFruits()
        }

        hideFruits()
    }

    private func stopTimers() {
        timer?.invalidate()
        hideTimer?.invalidate()
        timer = nil
        hideTimer = nil
    }

    private func updateHighScoreLabel() {
        let highScore = UserDefaults.standard.integer(forKey: highScoreKey)
        highscoreLabel.text = "HighScore : \(highScore)"
    }

    private func saveHighScoreIfNeeded() {
        let highScore = UserDefaults.standard.integer(forKey: highScoreKey)

        guard score > highScore else { return }

        UserDefaults.standard.set(score, forKey: highScoreKey)
        highscoreLabel.text = "HighScore : \(score)"
    }

    private func hideFruits() {
        for fruit in fruitsArray {
            fruit.isHidden = true
        }

        fruitsArray.randomElement()?.isHidden = false
    }

    private func countDown() {
        counter -= 1
        timeLabel.text = "Time : \(counter)"

        guard counter == 0 else { return }

        stopTimers()
        saveHighScoreIfNeeded()
        showTimeUpAlert()
    }

    private func showTimeUpAlert() {
        let alert = UIAlertController(title: "Time", message: "Time's Up !!!", preferredStyle: .alert)

        let replayButton = UIAlertAction(title: "Yep", style: .default) { [weak self] _ in
            self?.startGame()
        }

        let cancelButton = UIAlertAction(title: "Nope", style: .cancel)

        alert.addAction(replayButton)
        alert.addAction(cancelButton)

        present(alert, animated: true)
    }

    @objc private func increaseScore() {
        score += 1
        scoreLabel.text = "Score : \(score)"
    }
}
