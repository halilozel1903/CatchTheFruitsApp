//
//  ViewController.swift
//  CatchTheFruits
//
//  Created by Halil Özel on 13.12.2018.
//  Copyright © 2018 Halil Özel. All rights reserved.
//

import UIKit

private struct GameState {
    private let gameDuration: Int

    private(set) var score: Int
    private(set) var remainingTime: Int

    init(gameDuration: Int) {
        self.gameDuration = gameDuration
        self.score = 0
        self.remainingTime = gameDuration
    }

    mutating func reset() {
        score = 0
        remainingTime = gameDuration
    }

    mutating func incrementScore() {
        score += 1
    }

    mutating func tick() -> Bool {
        guard remainingTime > 0 else { return true }
        remainingTime -= 1
        return remainingTime == 0
    }
}

private protocol HighScoreStoring {
    func fetchHighScore() -> Int
    @discardableResult
    func saveIfHigher(score: Int) -> Int
}

private struct UserDefaultsHighScoreStore: HighScoreStoring {
    private let highScoreKey = "highScore"
    private let legacyHighScoreKey = "highscore"

    func fetchHighScore() -> Int {
        if UserDefaults.standard.object(forKey: highScoreKey) != nil {
            return UserDefaults.standard.integer(forKey: highScoreKey)
        }

        if UserDefaults.standard.object(forKey: legacyHighScoreKey) != nil {
            let legacyHighScore = UserDefaults.standard.integer(forKey: legacyHighScoreKey)
            UserDefaults.standard.set(legacyHighScore, forKey: highScoreKey)
            UserDefaults.standard.removeObject(forKey: legacyHighScoreKey)
            return legacyHighScore
        }

        return 0
    }

    func saveIfHigher(score: Int) -> Int {
        let currentHighScore = fetchHighScore()

        guard score > currentHighScore else {
            return currentHighScore
        }

        UserDefaults.standard.set(score, forKey: highScoreKey)
        return score
    }
}

@MainActor
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

    private static let gameDuration = 20
    private let fruitHideInterval: TimeInterval = 0.5
    private let highScoreStore: HighScoreStoring = UserDefaultsHighScoreStore()

    private var gameState = GameState(gameDuration: ViewController.gameDuration)
    private var timer: Timer?
    private var hideTimer: Timer?
    private var fruitsArray: [UIImageView] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        fruitsArray = [fruit1, fruit2, fruit3, fruit4, fruit5, fruit6, fruit7, fruit8, fruit9]
        configureGestures()
        updateHighScoreFromStorage()
        startGame()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimers()
    }

    private func configureGestures() {
        fruitsArray.forEach {
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(increaseScore)))
        }
    }

    private func startGame() {
        stopTimers()

        gameState.reset()
        renderGameState()

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

    private func renderGameState() {
        renderScore()
        renderTime()
    }

    private func updateHighScoreFromStorage() {
        renderHighScore(highScoreStore.fetchHighScore())
    }

    private func renderHighScore(_ value: Int) {
        highscoreLabel.text = "High Score: \(value)"
    }

    private func renderScore() {
        scoreLabel.text = "Score: \(gameState.score)"
    }

    private func renderTime() {
        timeLabel.text = "Time: \(gameState.remainingTime)"
    }

    private func hideFruits() {
        fruitsArray.forEach { $0.isHidden = true }
        fruitsArray.randomElement()?.isHidden = false
    }

    private func countDown() {
        let isGameFinished = gameState.tick()
        renderTime()

        guard isGameFinished else { return }

        stopTimers()

        let highScore = highScoreStore.saveIfHigher(score: gameState.score)
        renderHighScore(highScore)
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
        gameState.incrementScore()
        renderScore()
    }
}
