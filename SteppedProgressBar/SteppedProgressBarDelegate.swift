//
//  SteppedProgressBarDelegate.swift
//  SteppedProgressBar
//
//  Created by Don on 1/30/20.
//  Copyright © 2020 Don. All rights reserved.
//

import Foundation


@objc public protocol SteppedProgressBarDelegate {
    
    @objc optional func progressBar(_ progressBar: SteppedProgressBar,
                              willSelectItemAtIndex index: Int)
    
    @objc optional func progressBar(_ progressBar: SteppedProgressBar,
                              didSelectItemAtIndex index: Int)
    
    @objc optional func progressBar(_ progressBar: SteppedProgressBar,
                              canSelectItemAtIndex index: Int) -> Bool
    
    @objc optional func progressBar(_ progressBar: SteppedProgressBar,
                              textAtIndex index: Int, position: SteppedProgressBarTextLocation) -> String
}
