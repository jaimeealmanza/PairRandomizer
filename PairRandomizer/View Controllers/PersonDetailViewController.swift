//
//  PersonDetailViewController.swift
//  PairRandomizer
//
//  Created by Jaime Almanza on 23/02/18.
//  Copyright © 2018 Jaime Almanza. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {

    @IBOutlet weak var updateTextField: UITextField!
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        dismiss(animated: true) {
            guard let inputText = self.updateTextField.text,
                let person = self.person else { return }
            PersonController.shared.update(person: person, withName: inputText)
        }
    }
    
    
    // MARK: - Properties
    
    var person: Person?
    
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
