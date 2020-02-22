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
	
	public var color: UIColor = .blue
	
	public var strokeColor: UIColor = .cyan
	
	public var lineHeight: CGFloat = 6.0
	
	public init() { }
	
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
	
	
	public var selectedColor: UIColor = .blue
	
	public var unSelectedColor: UIColor = .gray
	
	public var inProgressColor: UIColor? = nil
	
	public var selectedFont: UIFont = .systemFont(ofSize: 14)
	
	public var unSelectedFont: UIFont = .systemFont(ofSize: 14)
	
	public var yOffset: CGFloat = 20.0
	
	public init() { }
	
	public init(color: UIColor, font: UIFont, offset: CGFloat) {
		yOffset = offset
		selectedColor = color
		unSelectedColor = color
		selectedFont = font
		unSelectedFont = font
	}
}
