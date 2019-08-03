//
//  NetworkController.swift
//  Friendji
//
//  Created by Kasra Abasi on 8/3/19.
//  Copyright © 2019 kasraabasi. All rights reserved.
//

/// This is the protocol oriented (POP) approach of handeling Networking, this is how mocking webservice api is possible

import Foundation

protocol NetworkController {
    func signUp(requestBody: [String: Any], completionHandler: @escaping (Bool, Error?) -> ())
    func retriveGame(requestBody: [String: Any], completionHandler: @escaping (GameViewModel?, Error?) -> ())
}
