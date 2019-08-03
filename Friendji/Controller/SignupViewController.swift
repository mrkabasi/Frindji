//
//  SignupViewController.swift
//  Friendji
//
//  Created by Kasra Abasi on 8/2/19.
//  Copyright © 2019 kasraabasi. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    // MARK: - Properties
    // switch between MockWebServiceNetworkController & WebServiceNetworkController
    private lazy var networkController = MockWebServiceNetworkController()
    
    // MARK: - Outlets
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageSegmentedControl: UISegmentedControl!
    @IBOutlet weak var favoriteColortextField: UITextField!
    @IBOutlet weak var favoriteFruitTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var pictureImageView: RoundableImageView!
    
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    // MARK: - Methods
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            bottomConstraint?.constant = -keyboardHeight
            if let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue {
                UIView.animate(withDuration: keyboardDuration) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        bottomConstraint?.constant = 0.0
        if let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject
            ).doubleValue {
            UIView.animate(withDuration: keyboardDuration) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    
    // MARK: - Actions
    
    @IBAction func cancelButtonDidTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func signupButtonDidTapped(_ sender: Any) {
        do {
            let requestBody = try attemptSignup()
            networkController.signUp(requestBody: requestBody) { (isRegistered, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                if isRegistered {
                    UserDefaults.standard.set(true, forKey: Constant.String.UserDefault.isRegistered)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        } catch let error {
            let errorMessage = error.localizedDescription
            presentAlert(with: errorMessage)
        }
    }
    @IBAction func addPictureButtonDidTapped(_ sender: Any) {
        let pictureImagePickerController = UIImagePickerController()
        pictureImagePickerController.delegate = self
        pictureImagePickerController.allowsEditing = true
        present(pictureImagePickerController, animated: true, completion: nil)
    }

}



// MARK: - Private Extension
private extension SignupViewController {
    
    // MARK: - Inner Types
    enum SignupError: String, Error, LocalizedError {
        case notSelectedGender = "Please Select Your Gender"
        case emptyNameTextField = "Please Enter Your Name"
        case notSelectedAge = "Please Select Your Age"
        case emptyFavoriteColortextField = "Please Enter Your Favorite Color"
        case emptyFavoriteFruitTextField = "Please Enter Your Favorite Fruit"
        case emptyPhoneNumberTextField = "Please Enter Your Phone Number"
        case emptyPictureImageView = "Please Select Your Picture"
        var errorDescription: String? { return NSLocalizedString((self.rawValue), comment: "") }
        
    }

    // MARK: - Methods
    func attemptSignup() throws -> [String: Any] {
        guard let gender = Gender(rawValue: genderSegmentedControl.selectedSegmentIndex) else {
            throw SignupError.notSelectedGender
        }
        guard let nameTextFieldText = nameTextField.text, !nameTextFieldText.isEmpty else {
            throw SignupError.emptyNameTextField
        }
        guard let age = AgeGroup(rawValue: ageSegmentedControl.selectedSegmentIndex) else {
            throw SignupError.notSelectedAge
        }
        guard let favoriteColortextFieldText = favoriteColortextField.text, !favoriteColortextFieldText.isEmpty else {
            throw SignupError.emptyFavoriteColortextField
        }
        guard let favoriteFruitTextFieldText = favoriteFruitTextField.text, !favoriteFruitTextFieldText.isEmpty else {
            throw SignupError.emptyFavoriteFruitTextField
        }
        guard let phoneNumberTextFieldText = phoneNumberTextField.text, !phoneNumberTextFieldText.isEmpty else {
            throw SignupError.emptyPhoneNumberTextField
        }
        guard let pictureImageViewImage = pictureImageView.image else {
            throw SignupError.emptyPictureImageView
        }
        let dictionary: [String: Any] = ["gender": gender, "name": nameTextFieldText, "age": age, "favoriteColor": favoriteColortextFieldText, "favoriteFruit": favoriteFruitTextFieldText, "phoneNumber": phoneNumberTextFieldText, "pictureImage": pictureImageViewImage]
        return dictionary
    }
    func presentAlert(with message: String) {
        let alert = UIAlertController(title: "Incomplete Form", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}



// MARK: - UITextFieldDelegate
extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



// MARK: - UIImagePickerControllerDelegate
extension SignupViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker {
            pictureImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}



// MARK: - UINavigationControllerDelegate
extension SignupViewController: UINavigationControllerDelegate {}
