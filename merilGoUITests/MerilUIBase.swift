//
//  MerilUIBase.swift
//  merilGoUITests
//
//  Created by Mehrene Saddique on 24/11/2023.
//

import XCTest

open class MerilUIBase: XCTestCase {
    
    let app = XCUIApplication()
    let springboard = XCUIApplication(bundleIdentifier: "com..apple.springboard")
    let defaultLaunchArguments: [String] = ["StartFromClleanState", "YES", "UITesting", "YES", "-DisableKeychainAccessGroup", "YES"]
    let timeOut5 = TimeInterval(5)
    
    
    public func launchApp(with launchArguments:[String] = []) {
        app.launchArguments = defaultLaunchArguments + launchArguments
        app.launch()
    }
    
    open override func setUp() {
        super.setUp()
        continueAfterFailure = true
        launchApp(with: defaultLaunchArguments)
    }
    
    public func hardCloseApp() {
        app.terminate()
    }
    
    public func relaunchApp() {
        app.terminate()
        self.launchApp()
    }
    
    func click(staticText: String) {
        app.staticTexts[staticText].firstMatch.tap()
    }
    
    func click(button: String) {
        app.buttons[button].firstMatch.tap()
    }
    
    func clickSecondButton(button: String) {
        app.buttons.matching(identifier: button).element(boundBy: 1).tap()
    }
    
    func clickLastText(statictext: String) {
        let text = app.staticTexts.matching(identifier: statictext)
        let staticTextCount = text.count
        text.element(boundBy: statictext.count - 1).tap()
    }
    
    func swipeLeftThroughImages(image: String, _step:Int = 0) {
        sleep(seconds: 2)
        let numberOfImages = app.images.matching(identifier: image)
        if numberOfImages.count>1 {
            if _step == 1 {
                numberOfImages.element(boundBy: 0).swipeLeft()
            }
            numberOfImages.element(boundBy: 1).swipeLeft()
        }
    }
    
    func shouldWaitForButtonToBeEnabled(button : String){
        var step = 0
        while !app.buttons[button].isEnabled {
            step += 1
            sleep(seconds: 2)
            if step > 20 {
                break
            }
        }
    }
    
    func shouldWaitForStaticTextToBeVisible(staticText : String){
        var swipes = 0
        while !app.staticTexts[staticText].firstMatch.isHittable {
            swipeUp()
            sleep(seconds: 2)
            if swipes > 10 {
                break
            }
            swipes+=1
        }
    }
    
    func swipeToLabelWhichContains(text: String) {
        var swipes = 0
        while !app.staticTexts.containing(NSPredicate(format: "label CONTAINS[c] %@", "\(text)")).firstMatch.exists {
            swipeUp()
            swipes += 1
            sleep(seconds: 2)
            if swipes > 15 {
                break
            }
        }
    }
    
    func swipeUp() {
        app.swipeUp()
    }
    
    func swipeDown() {
        app.swipeDown()
    }
    
    func waitForElementDoesNotExists(element: XCUIElement) {
        let doesNotExistPredicate = NSPredicate(format: "exists == FALSE")
        self.expectation(for: doesNotExistPredicate, evaluatedWith: element, handler: nil)
        self.waitForExpectations(timeout: timeOut5, handler: nil)
    }
    
    func checkStaticTextElementDoesNotExists(text: String) {
        waitForElementDoesNotExists(element: app.staticTexts[text])
    }
    
    func checkButtonElementDoesNotExists(text: String) {
        waitForElementDoesNotExists(element: app.buttons[text])
    }
    
    func getButtonLabel(button : String) -> String {
        app.buttons[button].firstMatch.label
    }
    
    func doesLabelExists(text: String, type: String = "text") -> Bool {
        let predicate = NSPredicate(format: "label CONTAINS[c] %@",text)
        var elementQuery = app.staticTexts.containing(predicate)
        
        if type == "button" {
            elementQuery = app.buttons.containing(predicate)
        }
        
        if elementQuery.element.waitForExistence(timeout: timeOut5) {
            if elementQuery.count > 0 {
                return true
            }
        }
        return false
    }
    
    func sleep(seconds: Int) {
        Thread.sleep(forTimeInterval: TimeInterval(seconds))
    }
    
    func printDebugDescription() {
        sleep(seconds: 20)
        print(app.debugDescription)
    }
    
    func getCurrentDateWithString(text:String) -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return text.appendingFormat(dateFormatter.string(from: date),text)
    }
    
    func typeTextWithDate(text: String) {
        app.typeText(getCurrentDateWithString(text: text))
    }
    
    func findUsernameField() -> Bool {
        app.textFields.firstMatch.waitForExistence(timeout: 10)
    }
    
    func clickUsernameField() {
        app.textFields.firstMatch.tap()
    }
    
    func typeText(text: String) {
        app.typeText(text)
    }
    
    func findPasswordField() -> Bool {
        app.secureTextFields.firstMatch.waitForExistence(timeout: 10)
    }
    
    func clickPasswordField() {
        app.secureTextFields.firstMatch.tap()
    }
    
}
