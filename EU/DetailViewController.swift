//
//  DetailViewController.swift
//  EU
//
//  Created by Korlin Favara on 1/2/22.
//

import UIKit

class DetailViewController: UITableViewController {
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var capitalField: UITextField!
    
    var countryName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if countryName == nil {
            countryName = ""
        }

        countryField.text = countryName
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        countryName = countryField.text
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        
            // code is asking the presentingViewController if it is a UINavigationController.
            // UINavigationControllers present modally - have to dismiss
            // otherwise view controller is not going through navigation controller - have to pop
            // it should be noted these are all in a higher level navigatio controller
            // isPresentingInAddMode becomes true or false
            let isPresentingInAddMode = presentingViewController is UINavigationController
            if isPresentingInAddMode {
                dismiss(animated: true, completion: nil)
            } else {
                // although at this point you would not be in a UINavigationController, popViewController pops the top view controller from the stack
                navigationController?.popViewController(animated: true)
            }
    }
    

}
  
