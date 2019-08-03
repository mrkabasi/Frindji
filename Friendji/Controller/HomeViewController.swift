//
//  HomeViewController.swift
//  Friendji
//
//  Created by Kasra Abasi on 8/3/19.
//  Copyright © 2019 kasraabasi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Actions
    @IBAction func playButtonDidTapped(_ sender: Any) {
        let isRegistered = UserDefaults.standard.bool(forKey: Constant.String.UserDefault.isRegistered)
        if isRegistered {
            performSegue(withIdentifier: Constant.String.SegueID.game, sender: nil)
        } else {
           performSegue(withIdentifier: Constant.String.SegueID.signup, sender: nil)
        }
    }
    
    
    
    // MARK: - Actions
    @IBAction func unwindToHomeViewController(segue: UIStoryboardSegue) {}

}
