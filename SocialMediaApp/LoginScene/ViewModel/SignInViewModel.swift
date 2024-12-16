//
//  SignInViewModel.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 13.11.2024.
//

//import Foundation
//
//protocol AuthViewModelSignInDelegate: AnyObject {
//    func didSignInSuccessfully(user: User)
//    func didFailToSignIn(with error: Error)
//    func didChangeLoadingState(isLoading: Bool)
//}
//
//class SignInViewModel {
//
//    weak var delegate: AuthViewModelSignInDelegate?
//
//    private var user: User?
//
//    func signIn(email: String, password: String) {
//        delegate?.didChangeLoadingState(isLoading: true)
//
//        AuthService.shared.signIn(email: email, password: password) { result in
//            self.delegate?.didChangeLoadingState(isLoading: false)
//            switch result {
//            case .success(let user):
//                self.user = user
//                self.delegate?.didSignInSuccessfully(user: user)
//            case .failure(let error):
//                self.delegate?.didFailToSignIn(with: error)
//            }
//        }
//    }
//}
