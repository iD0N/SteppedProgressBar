//
//  Extensions.swift
//  SteppedProgressBar
//
//  Created by Don on 2/1/20.
//  Copyright © 2020 Don. All rights reserved.
//

import UIKit


extension CATextLayer {
    
    func sizeWidthToFit() {
        let fontName = CTFontCopyPostScriptName(self.font as! CTFont) as String
        
        let font = UIFont(name: fontName, size: self.fontSize)
        
        let attributes = NSDictionary(object: font!, forKey: NSAttributedString.Key.font as NSCopying)
        
        let attString = NSAttributedString(string: self.string as! String, attributes: attributes as? [NSAttributedString.Key : AnyObject])
        
        var ascent: CGFloat = 0, descent: CGFloat = 0, width: CGFloat = 0
        
        let line = CTLineCreateWithAttributedString(attString)
        
        width = CGFloat(CTLineGetTypographicBounds( line, &ascent, &descent, nil))

        width = ceil(width)
        
        self.bounds = CGRect(x: 0, y: 0, width: width, height: ceil(ascent+descent))
    }
}

extension CGPoint {
    
    func distanceWith(_ p: CGPoint) -> CGFloat {
        return sqrt(pow(self.x - p.x, 2) + pow(self.y - p.y, 2))
    }

}
