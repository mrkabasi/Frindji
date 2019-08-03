//
//  WebServiceNetworkController.swift
//  Friendji
//
//  Created by Kasra Abasi on 8/3/19.
//  Copyright © 2019 kasraabasi. All rights reserved.
//

/// when web service api and backend is ready this class is responsible for handeling actual networking using NetworkingDataService
/// for now MockWebServiceNetworkController is mocking the requests

import Foundation

/*
 
struct WebServiceNetworkController: NetworkController {
    
    func signUp(requestBody: [String : Any], completionHandler: @escaping (Bool, Error?) -> ()) {
        NetworkingDataService.shared.sendHTTPRequest(for: SignUpModel.self, url: "url", method: .post, body: requestBody, token: nil) { result in
            switch result {
            case let .success(successData):
                completionHandler(successData.isRegistered, nil)
            case let .failure(error):
                completionHandler(false, error)
            }
        }
    }
    
}
 
*/
