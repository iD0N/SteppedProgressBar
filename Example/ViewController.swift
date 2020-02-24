//
//  ViewController.swift
//  Example
//
//  Created by Don on 2/24/20.
//  Copyright © 2020 Don. All rights reserved.
//

import UIKit
import SteppedProgressBar

class ViewController: UIViewController {

	@IBOutlet var progressBar: SteppedProgressBar!
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		progressBar.attributes.unselectedShape.color = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
		progressBar.attributes.unselectedShape.strokeColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
		progressBar.attributes.selectedShape.color = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
		progressBar.attributes.selectedShape.strokeColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
		progressBar.attributes.mainShape.color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		progressBar.attributes.mainShape.strokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		progressBar.attributes.text.center.selectedColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		progressBar.attributes.text.center.unSelectedColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
	}


}

