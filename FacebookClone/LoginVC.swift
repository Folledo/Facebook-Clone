//
//  LoginVC.swift
//  FacebookClone
//
//  Created by Samuel Folledo on 10/9/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class LoginVC: UIViewController { //FB ep.10 8mins
    
//UIObjects
    @IBOutlet weak var textFieldsView: UIView! //FB ep.10 8mins //weak will remove the reference one it moves to the next VC
    @IBOutlet weak var loginButton: UIButton! //FB ep.10 10mins
    
    @IBOutlet weak var leftLineView: UIView! //FB ep.11 10mins
    @IBOutlet weak var rightLineView: UIView! //FB ep.11 10mins
    
    @IBOutlet weak var registerButton: UIButton! //FB ep.11 17mins
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var handsImageView: UIImageView!
    
    
    
//UIConstraints
    @IBOutlet weak var coverImageView_top: NSLayoutConstraint! //FB ep.15 3mins
    @IBOutlet weak var whiteIconImageView_centerY: NSLayoutConstraint! //FB ep.15 1min
    @IBOutlet weak var handsImageView_top: NSLayoutConstraint! //FB ep.15 7mins
    @IBOutlet weak var registerButton_bottom: NSLayoutConstraint! //FB ep.17 
    
    
//cache objects
    var coverImageView_topCache: CGFloat! //FB ep.19 3mins
    var whiteIconImageView_centerYCache: CGFloat! //FB ep.19 3mins
    var handsImageView_topCache: CGFloat! //FB ep.19 3mins
    var registerButton_bottomCache: CGFloat! //FB ep.19 3mins
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coverImageView_topCache = coverImageView_top.constant //FB ep.19 5mins
        whiteIconImageView_centerYCache = whiteIconImageView_centerY.constant //FB ep.19 5mins
        handsImageView_topCache = handsImageView_top.constant //FB ep.19 5mins
        registerButton_bottomCache = registerButton_bottom.constant //FB ep.19 5mins
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) { //FB ep.18 2mins turn on notification observers
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil) //FB ep.13 3mins
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil) //FB ep.13 6mins
        
    }
    
    override func viewDidDisappear(_ animated: Bool) { //FB ep.18 2mins turn off notification observers when view disappears
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self) //FB ep.18 4mins
    }
    
//will Show keyboard
    @objc func keyboardWillShow(notification: Notification) { //FB ep.13 5mins
        print("keyboard will show")
        
        coverImageView_top.constant -= self.view.frame.width / 5.52 //FB ep.15 5mins //FB ep.19 7mins -= 75 is updated from constant to view's frame //if you divide the view's width by 75, we get 5.52, which will look the same proportions with this screen as well as other screen types
        handsImageView_top.constant -= self.view.frame.width / 5.52 //FB ep.16 7mins //FB ep.19 7mins
        whiteIconImageView_centerY.constant += self.view.frame.width / 8.28 //FB ep.16 4mins //FB ep.19 7mins += 50 updated to width / 8.28 which is 50
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue { //FB ep.17 4mins will store info which is passed by the notification (there's a lot) but specifically only access the keyboard's frame when it just begins to show to the user. And unwrap it as  an NSValue which we can conver to a cgRectValue
            registerButton_bottom.constant += keyboardSize.height //FB ep.17 6mins grab the keyboard's height
        }
        
        UIView.animate(withDuration: 0.5) { //FB ep.14 3mins
            self.handsImageView.alpha = 0 //FB ep.14 5mins
            self.view.layoutIfNeeded() //FB ep.15 5mins Lays out the subviews immediately, if layout updates are pending.
        }
        
    }
    
//will Hide keyboard
    @objc func keyboardWillHide(notification: Notification) { //FB ep.13 7mins
        print("keyboard will hide")
        
        coverImageView_top.constant = coverImageView_topCache //FB ep.15 6mins //FB ep.19 12mins += 75 is updated to = coverImageView_topCache
        handsImageView_top.constant = handsImageView_topCache //FB ep.16 7mins //FB ep.19 12mins
        whiteIconImageView_centerY.constant = whiteIconImageView_centerYCache //FB ep.16 2mins //FB ep.19 12mins
        
        //if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue { //FB ep.17 10mins
        registerButton_bottom.constant = registerButton_bottomCache //FB ep.17 10mins
        //}
        
        UIView.animate(withDuration: 0.5) { //FB ep.14 6mins
            self.handsImageView.alpha = 1 //FB ep.14 6mins
            self.view.layoutIfNeeded() //FB ep.15 7mins
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { //FB ep.13 11mins executed always when the screen is tapped unless tap is an object
        self.view.endEditing(false) //FB ep.13 12mins
    }
    
    override func viewDidLayoutSubviews() { //FB ep.10 24mins executed after aligning the subviews //better to call configuring views method than in viewDidLoad
        super.viewDidLayoutSubviews()
        
        configureTextFieldsView() //FB ep.10 25mins
        configureLoginButton() //FB ep.11
        configureOrLabel() //FB ep.11
        configureRegisterButton() //FB ep.11 20mins
    }
    
    
    func configureTextFieldsView() { //FB ep.10 10mins
        let width = CGFloat(2)
        let borderColor = UIColor.groupTableViewBackground.cgColor //FB ep.10 10mins //groupTableViewBackground = Returns the system color used for the background of a grouped table.
        
        let border = CALayer() //FB ep.10 10mins
        border.borderColor = borderColor
        border.frame = CGRect(x: 0, y: 0, width: textFieldsView.frame.width, height: textFieldsView.frame.height)
        border.borderWidth = width
        
        
        let line = CALayer() //FB ep.10 15mins
        line.borderWidth = width
        line.borderColor = borderColor
        line.frame = CGRect(x: 0, y: textFieldsView.frame.height / 2, width: textFieldsView.frame.width, height: width) //FB ep.10 18mins
        
         //FB ep.10 20mins assign the created layers to the view
        textFieldsView.layer.addSublayer(border)
        textFieldsView.layer.addSublayer(line)
        
         //FB ep.10 21mins rounded corders
        textFieldsView.layer.cornerRadius = 5 //FB ep.10 23mins
        textFieldsView.layer.masksToBounds = true //FB ep.10 23mins
    }
    
    func configureLoginButton() { //FB ep.11 4mins
        loginButton.layer.cornerRadius = 5 //FB ep.11 5mins
        loginButton.layer.masksToBounds = true //FB ep.11 5mins
        loginButton.isEnabled = false //FB ep.11 6mins
        
    }
    
    func configureOrLabel() { //FB ep.11 6mins
        let width = CGFloat(2)
        let color = UIColor.groupTableViewBackground.cgColor
        
        let leftLine = CALayer() //FB ep.11 8mins
        leftLine.borderWidth = width
        leftLine.borderColor = color
        leftLine.frame = CGRect(x: 0, y: leftLineView.frame.height / 2 - width, width: leftLineView.frame.width, height: width) //FB ep.11 10mins
        
        let rightLine = CALayer() //FB ep.11 11mins
        rightLine.borderWidth = width
        rightLine.borderColor = color
        rightLine.frame = CGRect(x: 0, y: rightLineView.frame.height / 2 - width, width: rightLineView.frame.width, height: width) //FB ep.11 13mins
        
        leftLineView.layer.addSublayer(leftLine) //FB ep.11 14mins
        rightLineView.layer.addSublayer(rightLine) //FB ep.11 14mins
    }
    
    
    func configureRegisterButton() { //FB ep.11 18mins
        let border = CALayer() //FB ep.11 18mins
        border.borderColor = UIColor.blue.cgColor
        border.borderWidth = 2
        border.frame = CGRect(x: 0, y: 0, width: registerButton.frame.width, height: registerButton.frame.height)
    
        registerButton.layer.addSublayer(border) //FB ep.11 19mins
        registerButton.layer.cornerRadius = 5
        registerButton.layer.masksToBounds = true //FB ep.11 19mins
    }
    
    
}
