//
//  SignUpViewModel.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 13.11.2024.
//

//import Foundation
//
//protocol AuthViewModelSignUpDelegate: AnyObject {
//    func didSignUpSuccessfully(user: User)
//    func didFailToSignUp(with error: Error)
//    func didChangeLoadingState(isLoading: Bool)
//}
//
//class SignUpViewModel {
//
//    weak var delegate: AuthViewModelSignUpDelegate?
//
//    private var user: User?
//
//    func signUp(email: String, password: String) {
//        delegate?.didChangeLoadingState(isLoading: true)
//        AuthService.shared.signUp(email: email, password: password) { result in
//            self.delegate?.didChangeLoadingState(isLoading: false)
//            print(email)
//            print(password)
//
//            switch result {
//            case .success(let user):
//                self.user = user
//                self.delegate?.didSignUpSuccessfully(user: user)
//            case .failure(let error):
//                print(error)
//                self.delegate?.didFailToSignUp(with: error)
//            }
//        }
//    }
//}
