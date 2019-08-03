//
//  GameViewController.swift
//  Friendji
//
//  Created by Kasra Abasi on 8/3/19.
//  Copyright © 2019 kasraabasi. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: - Properties
    // switch between MockWebServiceNetworkController & WebServiceNetworkController
    private lazy var networkController = MockWebServiceNetworkController()
    private var stage = 0
    private var emojiModel = EmojiModel(eyes: .close, eyeBrows: .normal, mouth: .neutral) { didSet { updateEmojiView() } }
    private let mouthCurvatures = [EmojiModel.Mouth.frown: -1.0, .neutral: 0.0, .smile: 1.0]
    private let eyeBrowTilts = [EmojiModel.Eyebrows.frown: -1.0, .normal: 0.0, .relax: 1.0]
    var game: GameViewModel? {
        didSet {
            updateUI()
            proceed()
        }
    }
    
    
    
    // MARK: - Outlets
    @IBOutlet weak var heartsLabel: UILabel!
    @IBOutlet weak var emojiView: EmojiView!
    
    
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        retriveGame(fileName: "stage0")
    }
    
    
    
    // MARK: - Actions
    @IBAction func submitEmojiButtonDidTapped(_ sender: Any) {
        // game senario from json stage files: match - not match - repeat - match - match - match
        stage += 1
        retriveGame(fileName: "stage\(stage)")
    }
    @IBAction func eybrowSegmentedControlDidShange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            emojiModel.eyeBrows = .normal
        case 1:
            emojiModel.eyeBrows = .relax
        case 2:
            emojiModel.eyeBrows = .frown
        default:
            break
        }
    }
    @IBAction func eyeSegmentedControlDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            emojiModel.eyes = .close
        case 1:
            emojiModel.eyes = .open
        default:
            break
        }
    }
    @IBAction func mouthSegmentedCOntrolDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            emojiModel.mouth = .neutral
        case 1:
            emojiModel.mouth = .smile
        case 2:
            emojiModel.mouth = .frown
        default:
            break
        }
    }
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.String.SegueID.prize {
            if let destination = segue.destination as? PrizeViewController {
                if let game = game {
                    destination.game = game
                }
            }
        }
    }
    
}



// MARK: - Private Extension
private extension GameViewController {
    
    // MARK: - Methods
    func retriveGame(fileName: String) {
        networkController.retriveGame(requestBody: ["stage":fileName]) { (game, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            if let game = game {
                self.game = game
            }
        }
    }
    func updateUI() {
        if let game = game {
            heartsLabel.text = game.heartsString
        }
    }
    func updateEmojiView() {
        if emojiView != nil {
            switch emojiModel.eyes {
            case .open: emojiView.isEyesOpen = true
            case .close: emojiView.isEyesOpen = false
            }
            emojiView.mouthCurvature = mouthCurvatures[emojiModel.mouth] ?? 0.0
            emojiView.eyeBrowTilt = eyeBrowTilts[emojiModel.eyeBrows] ?? 0.0
        }
    }
    func proceed() {
        if let isMatch = game?.isMatch {
            if isMatch {
                let alert = UIAlertController(title: "Match", message: "Open your prize", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Open", style: .default, handler: { _ in
                    self.performSegue(withIdentifier: Constant.String.SegueID.prize, sender: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Not Match", message: "You lost a heart, try again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        if let gameResult = game?.gameResult {
            switch gameResult {
            case .gameOver:
                let alert = UIAlertController(title: "Game Over", message: "See you next time", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Open", style: .default, handler: { _ in
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            default:
                break
            }
        }
    }
    
}
