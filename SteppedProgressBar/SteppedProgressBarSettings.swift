//
//  SteppedProgressBarSettings.swift
//  SteppedProgressBar
//
//  Created by Don on 1/30/20.
//  Copyright © 2020 Don. All rights reserved.
//

import UIKit

public struct SteppedProgressBarAttributes {
	
	
	static public let `default` = SteppedProgressBarAttributes()
	
	public var mainShape: ShapeAttributes = ShapeAttributes()
	
	public var unselectedShape: ShapeAttributes = ShapeAttributes()
	
	public var selectedShape: ShapeAttributes = ShapeAttributes()
	
	public var text: TextTypes = TextTypes()
	
	public init() { }
}

public struct ShapeAttributes {
	
	public var color: UIColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
	
	public var strokeColor: UIColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
	
	public var lineHeight: CGFloat = 3.0
	
	public init() { }
	
	/// Init
	/// - Parameters:
	///   - color: main shape's color
	///   - strokeColor: shape's stroke color
	///   - lineHeight: shape's line of height
	public init(color: UIColor,	strokeColor: UIColor, lineHeight: CGFloat)
	{
		self.color = color
		self.strokeColor = strokeColor
		self.lineHeight = lineHeight
	}
}

public struct TextTypes {
	
	
	public var top: TextAttributes = TextAttributes()
	
	public var center: TextAttributes = TextAttributes(color: .gray, font: .systemFont(ofSize: 14, weight: .bold), offset: 0)
	
	public var bottom: TextAttributes = TextAttributes()
	
	public init() { }
}


public struct TextAttributes {
	
	
	public var selectedColor: UIColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
	
	public var unSelectedColor: UIColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
	
	public var inProgressColor: UIColor? = nil
	
	public var selectedFont: UIFont = .systemFont(ofSize: 14, weight: .bold)
	
	public var unSelectedFont: UIFont = .systemFont(ofSize: 14, weight: .bold)
	
	public var yOffset: CGFloat = 20.0
	
	public init() { }
	
	/// init
	/// - Parameters:
	///   - color: text color
	///   - font: text font
	///   - offset: text top offset
	public init(color: UIColor, font: UIFont, offset: CGFloat) {
		yOffset = offset
		selectedColor = color
		unSelectedColor = color
		selectedFont = font
		unSelectedFont = font
	}
}
