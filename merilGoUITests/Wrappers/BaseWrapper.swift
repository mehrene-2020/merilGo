//
//  BaseWrapper.swift
//  merilGoUITests
//
//  Created by Mehrene Saddique on 24/11/2023.
//

import Foundation
import XCTest

open class BaseWrapper: MerilUIBase {
    //you'll define all your views objects
    
    public let loginView = LoginView()
    public let menuView = MenuView()
    
    open override func setUp() {
        super.setUp()
    }
    
    public func loginViaPublicAccount() {
        //AssertionToCheckthatAppHomescreenisVisible
        //Navigate to login view
        //Assertion to check that login view is visible
        
        loginView.logIn(userType: LoginView.UserTypes.publicUser)
        //Assertion that loggedin view is visible
        //logout
        //check home screen is visible
    }
    
    // You can define your common functions like login/logout/ Manu navigation etc
}
