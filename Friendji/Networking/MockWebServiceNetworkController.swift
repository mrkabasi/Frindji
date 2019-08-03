//
//  MockWebServiceNetworkController.swift
//  Friendji
//
//  Created by Kasra Abasi on 8/3/19.
//  Copyright © 2019 kasraabasi. All rights reserved.
//


/// This class is responsible for mocking HTTP requests
/// when web service api and backend is ready WebServiceNetworkController will handle networking using NetworkingDataService

import Foundation

struct MockWebServiceNetworkController: NetworkController {
    
    // MARK: - Methods
    func signUp(requestBody: [String : Any], completionHandler: @escaping (Bool, Error?) -> ()) {
        NetworkingDataService.shared.decodeJSONFromFile(fileName: "signup", for: SignUpModel.self) { result in
            switch result {
            case let .success(successData):
                DispatchQueue.main.async {
                    completionHandler(successData.isRegistered, nil)
                }
            case let .failure(error):
                completionHandler(false, error)
            }
        }
    }
    func retriveGame(requestBody: [String : Any], completionHandler: @escaping (GameViewModel?, Error?) -> ()) {
        NetworkingDataService.shared.decodeJSONFromFile(fileName: requestBody["stage"]! as! String, for: GameModel.self) { result in
            switch result {
            case let .success(successData):
                DispatchQueue.main.async {
                    let viewModel = GameViewModel(gameModel: successData)
                    completionHandler(viewModel, nil)
                }
            case let .failure(error):
                completionHandler(nil, error)
            }
        }
    }

    
}
