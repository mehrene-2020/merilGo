//
//  LoginView.swift
//  merilGoUITests
//
//  Created by Mehrene Saddique on 24/11/2023.
//

import Foundation
import XCTest

open class LoginView: MerilUIBase {
    
    public enum Logins {
        public static let publicUsername = "mehrene@gmail.com"
        public static let publicPassword = "abcdefg"
        public static let privateUsername = "mehrene@gmail.com"
        public static let privatePassword = "abcdefg"
    }
    
    public enum UserTypes {
        public static let publicUser = "guestaccount"
        public static let privateUser = "privateaccount"
    }
    
    public enum Buttons {
        public static let login = "Log In"
        public static let logout = "Log Out"
        public static let createAccout = "Create Account"
        public static let cancelButton = "Cancel"
        public static let backButton =  "Back"
        public static let continueButton =  "Cancel"
    }
    
    public enum staticTexts {
        public static let login = "Log In"
        public static let logout = "Log Out"
        public static let createYourAccout = "Create An Account"
        public static let signIn = "Sign In"
        public static let termsAndConditionsText =  "Agree to terms and conditions"
    }
    
    public func isUsernameFieldVisible() -> Bool {
        findUsernameField()
    }
    
    func tapUsernameField() {
        clickUsernameField()
    }
    
    func enterUsername(username: String = Logins.publicUsername) {
        typeText(text: username)
    }
    
    func tapPasswordField() {
        clickPasswordField()
    }
    
    func enterPassword(password: String = Logins.publicPassword) {
        typeText(text: password)
    }
    
    func clickLoginButton() {
        click(button: Buttons.login)
    }
    
    //Incase of multiple types of users.
    public func logIn(userType: String = UserTypes.publicUser) {
        var userCredentials = getPublicProfile()
        XCTAssertTrue(findUsernameField())
        XCTAssertTrue(findPasswordField())
        
        switch userType {
        case UserTypes.publicUser:
            userCredentials = getPublicProfile()
        case UserTypes.privateUser:
            userCredentials =  getPrivateProfile()
        default:
            userCredentials = getPublicProfile()
        }
        
        tapUsernameField()
        enterUsername(username: userCredentials.username)
        tapPasswordField()
        enterPassword(password: userCredentials.password)
        clickLoginButton()
    }
    
    func getPublicProfile() -> Account {
        return Account(username: Logins.publicPassword, password: Logins.publicPassword)
    }
    
    func getPrivateProfile() -> Account {
        return Account(username: Logins.privatePassword, password: Logins.privatePassword)
    }
    
    
    public struct Account {
        var username: String
        var password: String
        
        init(username: String, password: String) {
            self.username = username
            self.password = password
        }
    }
}
