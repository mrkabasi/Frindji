//
//  PrizeViewController.swift
//  Friendji
//
//  Created by Kasra Abasi on 8/3/19.
//  Copyright © 2019 kasraabasi. All rights reserved.
//

import UIKit

class PrizeViewController: UIViewController {
    
    // MARK: - Properties
    var game: GameViewModel? 
    
    
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var discriptioLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    
    
    // MARK: - Actions
    @IBAction func notInterestedButtonDidTapped(_ sender: Any) {
        /// close the game in server
        performSegue(withIdentifier: Constant.String.SegueID.unwindToHome, sender: self)
    }
    @IBAction func continueButtonDidTapped(_ sender: Any) {
        switch game!.gameResult {
        case .phoneNumberSharing:
            performSegue(withIdentifier: Constant.String.SegueID.unwindToHome, sender: self)
        default:
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    
}



// MARK: - Private Extension
private extension PrizeViewController {
    
    // MARK: - Methods
    func updateUI() {
        if let game = game {
            switch game.gameResult {
            case .nameSharing:
                titleLabel?.text = "Your Frindjis Name is"
                discriptioLabel?.text = game.playerNameString
            case .ageSharing:
                titleLabel?.text = "Your Frindjis age is"
                discriptioLabel?.text = game.playerAgeString
            case .favoritesSharing:
                titleLabel?.text = "Your Frindjis favorites are"
                discriptioLabel?.text = game.playerFavoritsString
            case .pictureSharing:
                if let url = game.playerPictureURL {
                    imageView.downloadImageUsingCache(url: url)
                }
            case .phoneNumberSharing:
                titleLabel?.text = "Your Frindjis Phone Number is"
                discriptioLabel?.text = game.playerPhoneNumberString
            case .gameOver:
                break
            }
        }
    }
}

