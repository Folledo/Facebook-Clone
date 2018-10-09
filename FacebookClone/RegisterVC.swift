//
//  RegisterVC.swift
//  FacebookClone
//
//  Created by Samuel Folledo on 10/9/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView! //FB ep.31
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    
    @IBOutlet weak var emailContinueButton: UIButton!
    @IBOutlet weak var fullNameContinueButton: UIButton!
    @IBOutlet weak var passwordContinueButton: UIButton!
    @IBOutlet weak var birthdayContinueButton: UIButton!
    @IBOutlet weak var femaleGenderButton: UIButton!
    @IBOutlet weak var maleGenderButton: UIButton!
    
    @IBOutlet weak var footerView: UIView! //FB ep.28 6mins
    
    var birthDatePicker: UIDatePicker! //FB ep.32 1min
    
    
    
    
    
    //constraints object
    @IBOutlet weak var contentViewWidth: NSLayoutConstraint! //FB ep.26 11mins
    @IBOutlet weak var emailViewWidth: NSLayoutConstraint! //FB ep.26 10mins
    @IBOutlet weak var nameViewWidth: NSLayoutConstraint! //FB ep.26 10mins
    @IBOutlet weak var passwordViewWidth: NSLayoutConstraint! //FB ep.26 10mins
    @IBOutlet weak var birthdayViewWidth: NSLayoutConstraint! //FB ep.26 10mins
    @IBOutlet weak var genderViewWidth: NSLayoutConstraint! //FB ep.26 10mins
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.isScrollEnabled = false //FB ep.31 1min
        setupContentViews()
        
        birthDatePicker = UIDatePicker() //FB ep.32 1min
        birthDatePicker.datePickerMode = .date //FB ep.32 1min
        birthDatePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -5, to: Date()) //FB ep.32 2mins this restrics the user from picking a date before 5 years ago from current date, has to be more than 5 years old
        birthDatePicker.addTarget(self, action: #selector(datePickerDidChange(_:)), for: .valueChanged) //FB ep.32 5mins
        birthdayTextField.inputView = birthDatePicker //FB ep.32 5mins make the date picked as the birthday text field's inputView //inputView = The custom input view to display when the text field becomes the first responder. //instead of launching a keyboard, it will laucnh datePicker isntead
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:))) //FB ep.33 2mins create the gesture recog
        swipe.direction = .right //FB ep.33 3mins
        self.view.addGestureRecognizer(swipe) //FB ep.33 4mins add it to the view
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        self.view.endEditing(false)
    }
    
    override func viewDidLayoutSubviews() { //FB ep.28 17mins executed once the auto-layout has been applied/executed, thats why configures are called here
        super.viewDidLayoutSubviews() //FB ep.28 17mins
        
        DispatchQueue.main.async { //FB ep.28 18mins
            self.configureFooterView() //FB ep.28 9mins
            self.configureButtons(gender: self.femaleGenderButton) //FB ep.28 15mins
            self.configureButtons(gender: self.maleGenderButton) //FB ep.28 15mins
        }
    }
    
    
    func setupContentViews() {
        contentViewWidth.constant = self.view.frame.width * 5 //FB ep.26 13mins//this mother contentView, we will programmatically match the view.frame's width by multiplying it by 5 for our 5 views
        
        emailViewWidth.constant = self.view.frame.width //FB ep.26 12mins
        nameViewWidth.constant = self.view.frame.width //FB ep.26 12mins
        passwordViewWidth.constant = self.view.frame.width //FB ep.26 12mins
        birthdayViewWidth.constant = self.view.frame.width //FB ep.26 12mins
        genderViewWidth.constant = self.view.frame.width //FB ep.26 12mins
        
    //make corners of the objects rounded
        cornerRadius(for: emailTextField) //FB ep.27 10mins
        cornerRadius(for: firstNameTextField) //FB ep.27 10mins
        cornerRadius(for: lastNameTextField) //FB ep.27 10mins
        cornerRadius(for: passwordTextField) //FB ep.27 10mins
        cornerRadius(for: birthdayTextField) //FB ep.27 10mins
        
        cornerRadius(for: emailContinueButton) //FB ep.27 10mins
        cornerRadius(for: fullNameContinueButton) //FB ep.27 10mins
        cornerRadius(for: passwordContinueButton) //FB ep.27 10mins
        cornerRadius(for: birthdayContinueButton) //FB ep.27 10mins
        
    //give a left padding to the text fields
        padding(for: emailTextField) //FB ep.28 4mins
        padding(for: firstNameTextField) //FB ep.28 4mins
        padding(for: lastNameTextField) //FB ep.28 4mins
        padding(for: passwordTextField) //FB ep.28 4mins
        padding(for: birthdayTextField) //FB ep.28 4mins
        
        Helper.hideButton(button: emailContinueButton)
        Helper.hideButton(button: fullNameContinueButton)
        Helper.hideButton(button: passwordContinueButton)
        Helper.hideButton(button: birthdayContinueButton)
    }
    
    
    func configureButtons(gender button: UIButton) { //FB ep.28 10mins
        let border = CALayer() //FB ep.28 11mins
        border.borderWidth = 1.5
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: 0, width: button.frame.width, height: button.frame.height) //FB ep.28 12mins
        
    //now assign layer created to the button
        button.layer.addSublayer(border) //FB ep.28 13mins
        
        button.layer.cornerRadius = 5 //FB ep.28 14mins
        button.layer.masksToBounds = true //FB ep.28 14mins
    }
    
    
    func configureFooterView() { //FB ep.28 7mins method to configure footerView's appearance
        let topLine = CALayer() //FB ep.28 7mins
        topLine.borderWidth = 1
        topLine.borderColor = UIColor.lightGray.cgColor
        topLine.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 1) //FB ep.28 8mins
        
        footerView.layer.addSublayer(topLine) //FB ep.28 8mins
        
    }
    
    func padding(for textField: UITextField) { //FB ep.28 1min
        let blankView = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 20)) //FB ep.28 2mins
        textField.leftView = blankView //FB ep.28 3mins leftView = The overlay view displayed on the left (or leading) side of the text field.
        textField.leftViewMode = .always //FB ep.28 4mins //leftViewMode = Controls when the left overlay view appears in the text field.
    }
    
    func cornerRadius(for view: UIView) { //FB ep.27 5mins, this UIView can be applied to button, text field, etc.
        view.layer.cornerRadius = 5 //FB ep.27 6mins
        view.layer.masksToBounds = true //FB ep.27 6mins
    }
    
    
    @IBAction func alreadyHaveAccountTapped(_ sender: Any) { //FB ep.27 2mins
        self.dismiss(animated: true, completion: nil) //FB ep.27 2mins
    }
    
    
    @IBAction func emailContinueButtonTapped(_ sender: Any) { //FB ep.30 2mins
        
        let position = CGPoint(x: self.view.frame.width, y: 0) //FB ep.31, 2mins moves to the next page, because the x is the right side most of the screen
        scrollView.setContentOffset(position, animated: true)
        
        if firstNameTextField.text!.isEmpty { //FB ep.32 13mins
            firstNameTextField.becomeFirstResponder() //FB ep.32 13mins
        } else if lastNameTextField.text!.isEmpty { //FB ep.32 13mins
            lastNameTextField.becomeFirstResponder() //FB ep.32 13mins
        } else if firstNameTextField!.text!.isEmpty == false &&
            lastNameTextField.text?.isEmpty == false { //FB ep.32 14mins
            firstNameTextField.resignFirstResponder() //FB ep.32 14mins
            lastNameTextField.resignFirstResponder() //FB ep.32 14mins
        }
        
    }
    
    @IBAction func fullNameContinueButtonTapped(_ sender: Any) { //FB ep.30 2mins
        let position = CGPoint(x: self.view.frame.width * 2, y: 0) //FB ep.31 3mins
        scrollView.setContentOffset(position, animated: true) //FB ep.31 3mins
        
        if passwordTextField.text!.isEmpty { //FB ep.32 15mins
            passwordTextField.becomeFirstResponder() //FB ep.32 15mins
        } else if passwordTextField.text!.isEmpty == false { //FB ep.32 16mins
            passwordTextField.resignFirstResponder() //FB ep.32 16mins
        }
    }
    
    @IBAction func passwordContinueButtonTapped(_ sender: Any) { //FB ep.30 2mins
        let position = CGPoint(x: self.view.frame.width * 3, y: 0) //FB ep.31 3mins
        scrollView.setContentOffset(position, animated: true) //FB ep.31 3mins
        if birthdayTextField.text!.isEmpty { //FB ep.32 16mins
            birthdayTextField.becomeFirstResponder() //FB ep.32 16mins
        } else if birthdayTextField.text!.isEmpty == false { //FB ep.32 16mins
            birthdayTextField.resignFirstResponder() //FB ep.32 16mins
        }
    }
    
    @IBAction func birthdayContinueButtonTapped(_ sender: Any) { //FB ep.30 2mins
        let position = CGPoint(x: self.view.frame.width * 4, y: 0) //FB ep.31 3mins
        scrollView.setContentOffset(position, animated: true) //FB ep.31 3mins
        
        birthdayTextField.resignFirstResponder() //FB ep.32 16mins hide keyboard or date picker
    }
    
    
    @IBAction func textFieldDidChange(_ textField: UITextField) { //FB ep.30 7mins action method for all our textFields with a editing changed send event for textField types only
        if textField == emailTextField { //FB ep.30 10mins
            guard let emailText = emailTextField.text  else { return }
            if Helper.isValid(email: emailText) { //FB ep.30 10mins
                print("\(emailText) Valid email")
                Helper.showButton(button: emailContinueButton) //showButton
            } else { //FB ep.30 10mins
                print("\(emailText) is not a valid email")
                Helper.hideButton(button: emailContinueButton)
            }
            
        } else if (textField == firstNameTextField) || (textField == lastNameTextField) { //FB ep.30 10mins
            guard let firstNameText = firstNameTextField.text else { return }
            guard let lastNameText = lastNameTextField.text  else { return }
            if Helper.isValid(name: firstNameText) && Helper.isValid(name: lastNameText) { //FB ep.30 10mins
                Helper.showButton(button: fullNameContinueButton)
                
            } else { //FB ep.30 10mins
                Helper.hideButton(button: fullNameContinueButton)
                
            }
        } else if textField == passwordTextField{ //FB ep.30 10mins
            guard let passwordText = passwordTextField.text  else { return }
            if passwordText.count >= 6 { //FB ep.30 13mins greater than 6 chars
                print("password valid")
                Helper.showButton(button: passwordContinueButton)
            } else { //FB ep.30 10mins
                print("password invalid")
                Helper.hideButton(button: passwordContinueButton)
            }
        }
    }
    
    
    @objc func datePickerDidChange(_ datePicker: UIDatePicker) { //FB ep.32 3mins this method is ran whenever a date is selected
        let formatter = DateFormatter() //FB ep.32 7mins
        formatter.dateStyle = DateFormatter.Style.medium //FB ep.32 7mins
        birthdayTextField.text = formatter.string(from: birthDatePicker.date) //FB ep.32 8mins (Oct 7, 1995)
        
        let compareDateFormatter = DateFormatter() //FB ep.32 9mins
        compareDateFormatter.dateFormat = "yyyy/MM/dd HH:mm" //FB ep.32 9mins create a dateFormat, then place a date we want to compare with our birthDatePicker
        guard let compareDate = compareDateFormatter.date(from: "2013/01/01 00:01") else { return }//FB ep.32 10 mins we dont want anyone to be registered who is later than this date in (from: )
        
        if birthDatePicker.date < compareDate { //FB ep.32 10mins if user is older than 5 years, show continue button
            Helper.showButton(button: birthdayContinueButton) //FB ep.32 10mins
        } else { //FB ep.32 10mins
            Helper.hideButton(button: birthdayContinueButton) //FB ep.32 10mins
        }
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) { //FB ep.33 2mins will be called once user swipes to the right
        let currentX = scrollView.contentOffset.x //FB ep.33 5mins //contentOffset = The point at which the origin of the content view is offset from the origin of the scroll view. Get the x coordinate of the point //we get the current position of the scrollView
        let newX = CGPoint(x: currentX - self.view.frame.width, y: 0) //FB ep.33 5mins this will give us the the previous screen's x
        if currentX > 0 { //FB ep.33 7mins we will only allow to swipe back if x is greater than 0, so we wont go past the emailView
            scrollView.setContentOffset(newX, animated: true) //FB ep.33 6mins now set the scrollView to the new X
        }
    }
    
}
