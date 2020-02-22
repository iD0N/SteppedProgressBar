//
//  SteppedProgressBar.swift
//  SteppedProgressBar
//
//  Created by Don on 1/30/20.
//  Copyright © 2020 Don. All rights reserved.
//

import UIKit

@IBDesignable
public class SteppedProgressBar: UIView {
	
	public var delegate: SteppedProgressBarDelegate?
	
	public var attributes: SteppedProgressBarAttributes = .default {
		didSet {
			self.applyAttributes()
			self.setNeedsDisplay()
		}
	}
	public var stepCount: Int = 3 {
		didSet {
			self.setNeedsDisplay()
		}
	}
	public var radius: CGFloat = 10 {
		didSet {
			self.invalidateIntrinsicContentSize()
			self.setNeedsDisplay()
		}
	}
	public var selectedIndex: Int = 0 {
		didSet {
			self.setNeedsDisplay()
		}
	}
	var centers: [CGPoint] = []
	
	
	fileprivate var textLayers: [Int : CATextLayer] = [:]
	fileprivate var mainShape = CAShapeLayer()
	fileprivate var unselectedShape = CAShapeLayer()
	fileprivate var selectedShape = CAShapeLayer()
	
	fileprivate var _topTextLayers: [Int : CATextLayer] = [:]
	
	override public init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required public init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	override public var intrinsicContentSize: CGSize {
		let size = super.intrinsicContentSize
		return CGSize(width: size.width, height: radius * 2 + attributes.text.top.yOffset + attributes.text.bottom.yOffset)
	}
	func commonInit() {
		applyAttributes()
		
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.gestureAction(_:)))
        let swipeGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.gestureAction(_:)))
        self.addGestureRecognizer(tapGestureRecognizer)
        self.addGestureRecognizer(swipeGestureRecognizer)
		
		self.layer.addSublayer(mainShape)
		self.layer.addSublayer(unselectedShape)
		self.layer.addSublayer(selectedShape)
	}
	func applyAttributes() {
		
		mainShape.strokeColor = attributes.mainShape.strokeColor.cgColor
		mainShape.fillColor = attributes.mainShape.color.cgColor
		mainShape.lineWidth = attributes.mainShape.lineHeight
		
		unselectedShape.fillColor = attributes.unselectedShape.color.cgColor
		unselectedShape.strokeColor = attributes.unselectedShape.strokeColor.cgColor
		unselectedShape.lineWidth = attributes.unselectedShape.lineHeight
		
		
		selectedShape.fillColor = attributes.selectedShape.color.cgColor
		selectedShape.strokeColor = attributes.selectedShape.strokeColor.cgColor
		selectedShape.lineWidth = attributes.selectedShape.lineHeight
		
	}
	override public func draw(_ rect: CGRect) {
        super.draw(rect)
		
        let stepDistance = (self.bounds.width - (CGFloat(stepCount * 2) * radius)) / CGFloat(stepCount - 1)
        
        var xCursor: CGFloat = radius
		var centers: [CGPoint] = []
        for _ in 0...(stepCount - 1) {
            centers.append(CGPoint(x: xCursor, y: bounds.height / 2))
            xCursor += 2 * radius + stepDistance
        }
		self.centers = centers
		let path = drawShape(centers: centers, radius: radius)
		
		mainShape.path = path.cgPath
		
		unselectedShape.path = path.cgPath
		
		let path2 = drawShape(centers: Array(centers[0...selectedIndex]), radius: radius)
		
		selectedShape.path = path2.cgPath
		
		renderTextIndexes(centers: centers)
        renderTopTextIndexes(centers: centers)
	}
	
	func drawShape(centers: [CGPoint], radius: CGFloat, drawLines: Bool = true) -> UIBezierPath {
		let path = UIBezierPath()
		for i in 0...centers.count - 1
		{
			path.addArc(withCenter: centers[i], radius: radius, startAngle: 0, endAngle:  2 * .pi, clockwise: true)
			path.move(to: CGPoint(x: centers[i].x + radius, y: centers[i].y))
			if i + 1 != centers.count
			{
				if drawLines {
					path.addLine(to: CGPoint(x: centers[i+1].x - (radius), y: centers[i+1].y))
				}
				path.move(to: CGPoint(x: centers[i+1].x + radius, y: centers[i+1].y))
			}
		}
		path.close()
		return path
	}
	
    fileprivate func textLayer(atIndex index: Int) -> CATextLayer {
        
        var textLayer: CATextLayer
        if let _textLayer = textLayers[index] {
            textLayer = _textLayer
        } else {
            textLayer = CATextLayer()
            textLayers[index] = textLayer
        }
        self.layer.addSublayer(textLayer)
        
        return textLayer
    }
    fileprivate func renderTextIndexes(centers: [CGPoint]) {
        
        for i in 0...(stepCount - 1) {
            let textLayer = self.textLayer(atIndex: i)
            
			let textLayerFont = attributes.text.center.selectedFont
            textLayer.contentsScale = UIScreen.main.scale
            
            textLayer.font = CTFontCreateWithName(textLayerFont.fontName as CFString, textLayerFont.pointSize, nil)
            textLayer.fontSize = textLayerFont.pointSize
            
			textLayer.string = delegate?.progressBar?(self, textAtIndex: i, position: .center) ?? "\(i + 1)"
			
			textLayer.foregroundColor = (selectedIndex >= i) ? attributes.text.center.selectedColor.cgColor : attributes.text.center.unSelectedColor.cgColor
            textLayer.sizeWidthToFit()
            
			textLayer.frame = CGRect(x: centers[i].x - textLayer.bounds.width/2, y: centers[i].y - textLayer.bounds.height/2 - attributes.text.center.yOffset, width: textLayer.bounds.width, height: textLayer.bounds.height)
        }
    }
    fileprivate func _topTextLayer(atIndex index: Int) -> CATextLayer {
        
        var textLayer: CATextLayer
        if let _textLayer = self._topTextLayers[index] {
            textLayer = _textLayer
        } else {
            textLayer = CATextLayer()
            self._topTextLayers[index] = textLayer
        }
        self.layer.addSublayer(textLayer)
        
        return textLayer
    }
    fileprivate func renderTopTextIndexes(centers: [CGPoint]) {
        
		
        for i in 0...(stepCount - 1) {
            let textLayer = self._topTextLayer(atIndex: i)
            
			let textLayerFont = attributes.text.top.selectedFont
            textLayer.contentsScale = UIScreen.main.scale
            
            textLayer.font = CTFontCreateWithName(textLayerFont.fontName as CFString, textLayerFont.pointSize, nil)
            textLayer.fontSize = textLayerFont.pointSize
			textLayer.foregroundColor = (selectedIndex >= i) ? attributes.text.top.selectedColor.cgColor : attributes.text.top.unSelectedColor.cgColor
			textLayer.string = delegate?.progressBar?(self, textAtIndex: i, position: .top) ?? "\(i + 1)"
			
            textLayer.sizeWidthToFit()
            
			textLayer.frame = CGRect(x: centers[i].x - textLayer.bounds.width/2, y: centers[i].y - textLayer.bounds.height/2 - radius - 20.0, width: textLayer.bounds.width, height: textLayer.bounds.height)
        }
    }
	
    /**
     Respond to the user action
     
     - parameter gestureRecognizer: The gesture recognizer responsible for the action
     */
    @objc func gestureAction(_ gestureRecognizer: UIGestureRecognizer) {
        if(gestureRecognizer.state == UIGestureRecognizer.State.ended ||
            gestureRecognizer.state == UIGestureRecognizer.State.changed ) {
            
            let touchPoint = gestureRecognizer.location(in: self)
            
            var smallestDistance = CGFloat(Float.infinity)
            
            var selectedIndex = 0
            
            for (index, point) in self.centers.enumerated() {
                let distance = touchPoint.distanceWith(point)
                if(distance < smallestDistance) {
                    smallestDistance = distance
                    selectedIndex = index
                }
            }
            
            
            
			if(self.selectedIndex != selectedIndex && (delegate?.progressBar?(self, canSelectItemAtIndex: selectedIndex) ?? true)) {
				delegate?.progressBar?(self, willSelectItemAtIndex: selectedIndex)
				self.selectedIndex = selectedIndex
				self.setNeedsDisplay()
				
				delegate?.progressBar?(self, didSelectItemAtIndex: selectedIndex)
            }
        }
    }
    
}

/*
@IBDesignable
class SteppedProgressBar: UIView {
	
	var stepCount: Int = 3 {
		didSet {
			self.setNeedsDisplay()
		}
	}
	var radius: CGFloat = 10 {
		didSet {
			self.setNeedsDisplay()
		}
	}
	var selectedIndex: Int = 0 {
		didSet {
			self.setNeedsDisplay()
		}
	}
	var centers: [CGPoint] = []
	
	fileprivate var textLayers: [Int : CATextLayer] = [:]
	fileprivate var mainShape = CAShapeLayer()
	fileprivate var unselectedShape = CAShapeLayer()
	fileprivate var selectedShape = CAShapeLayer()
	
	fileprivate var _topTextLayers: [Int : CATextLayer] = [:]
    
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	override var intrinsicContentSize: CGSize {
		let size = super.intrinsicContentSize
		return CGSize(width: self.bounds.width, height: radius * 2 + 40.0)
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	func commonInit() {
		mainShape.strokeColor = UIColor.veryLightPink.cgColor
		mainShape.fillColor = UIColor.clear.cgColor
		mainShape.lineWidth = 6.0
		
		unselectedShape.fillColor = UIColor.white.cgColor
		unselectedShape.strokeColor = UIColor.clear.cgColor
		unselectedShape.lineWidth = 6.0
		
		
		selectedShape.fillColor = UIColor.twilightBlue.cgColor
		selectedShape.strokeColor = UIColor.cerulean.withAlphaComponent(0.2).cgColor
		selectedShape.lineWidth = 6.0
		
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.gestureAction(_:)))
        let swipeGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.gestureAction(_:)))
        self.addGestureRecognizer(tapGestureRecognizer)
        self.addGestureRecognizer(swipeGestureRecognizer)
        
		
		self.layer.addSublayer(mainShape)
		self.layer.addSublayer(unselectedShape)
		self.layer.addSublayer(selectedShape)
	}
	override func draw(_ rect: CGRect) {
        super.draw(rect)
		
        let stepDistance = (self.bounds.width - (CGFloat(stepCount * 2) * radius)) / CGFloat(stepCount - 1)
        
        var xCursor: CGFloat = radius
		var centers: [CGPoint] = []
        for _ in 0...(stepCount - 1) {
            centers.append(CGPoint(x: xCursor, y: bounds.height / 2))
            xCursor += 2 * radius + stepDistance
        }
		self.centers = centers
		let path = drawShape(centers: centers, radius: radius)
		
		mainShape.path = path.cgPath
		
		unselectedShape.path = path.cgPath
		
		let path2 = drawShape(centers: Array(centers[0...selectedIndex]), radius: radius)
		
		selectedShape.path = path2.cgPath
		
		renderTextIndexes(centers: centers)
        renderTopTextIndexes(centers: centers)
	}
	
	func drawShape(centers: [CGPoint], radius: CGFloat, drawLines: Bool = true) -> UIBezierPath {
		let path = UIBezierPath()
		for i in 0...centers.count - 1
		{
			path.addArc(withCenter: centers[i], radius: radius, startAngle: 0, endAngle:  2 * .pi, clockwise: true)
			path.move(to: CGPoint(x: centers[i].x + radius, y: centers[i].y))
			if i + 1 != centers.count
			{
				if drawLines {
					path.addLine(to: CGPoint(x: centers[i+1].x - (radius), y: centers[i+1].y))
				}
				path.move(to: CGPoint(x: centers[i+1].x + radius, y: centers[i+1].y))
			}
		}
		path.close()
		return path
	}
	
    fileprivate func textLayer(atIndex index: Int) -> CATextLayer {
        
        var textLayer: CATextLayer
        if let _textLayer = textLayers[index] {
            textLayer = _textLayer
        } else {
            textLayer = CATextLayer()
            textLayers[index] = textLayer
        }
        self.layer.addSublayer(textLayer)
        
        return textLayer
    }
    fileprivate func renderTextIndexes(centers: [CGPoint]) {
        
        for i in 0...(stepCount - 1) {
            let textLayer = self.textLayer(atIndex: i)
            
            let textLayerFont = UIFont.manoParkFont(size: 14)
            textLayer.contentsScale = UIScreen.main.scale
            
            textLayer.font = CTFontCreateWithName(textLayerFont.fontName as CFString, textLayerFont.pointSize, nil)
            textLayer.fontSize = textLayerFont.pointSize
			textLayer.foregroundColor = (selectedIndex >= i) ? UIColor.white.cgColor : UIColor.black.cgColor
            textLayer.string = "\(i + 1)"
			
            textLayer.sizeWidthToFit()
            
			textLayer.frame = CGRect(x: centers[i].x - textLayer.bounds.width/2, y: centers[i].y - textLayer.bounds.height/2 + 4.0, width: textLayer.bounds.width, height: textLayer.bounds.height)
        }
    }
    fileprivate func _topTextLayer(atIndex index: Int) -> CATextLayer {
        
        var textLayer: CATextLayer
        if let _textLayer = self._topTextLayers[index] {
            textLayer = _textLayer
        } else {
            textLayer = CATextLayer()
            self._topTextLayers[index] = textLayer
        }
        self.layer.addSublayer(textLayer)
        
        return textLayer
    }
    fileprivate func renderTopTextIndexes(centers: [CGPoint]) {
        
		
        for i in 0...(stepCount - 1) {
            let textLayer = self._topTextLayer(atIndex: i)
            
            let textLayerFont = UIFont.manoParkFont(size: 15)
            textLayer.contentsScale = UIScreen.main.scale
            
            textLayer.font = CTFontCreateWithName(textLayerFont.fontName as CFString, textLayerFont.pointSize, nil)
            textLayer.fontSize = textLayerFont.pointSize
			textLayer.foregroundColor = (selectedIndex >= i) ? UIColor.twilightBlue.cgColor : UIColor.veryLightPink.cgColor
            textLayer.string = ["پلاک", "مدل", "رنگ"][i]
			
            textLayer.sizeWidthToFit()
            
			textLayer.frame = CGRect(x: centers[i].x - textLayer.bounds.width/2, y: centers[i].y - textLayer.bounds.height/2 - radius - 20.0, width: textLayer.bounds.width, height: textLayer.bounds.height)
        }
    }
	
    
    /**
     Respond to the user action
     
     - parameter gestureRecognizer: The gesture recognizer responsible for the action
     */
    @objc func gestureAction(_ gestureRecognizer: UIGestureRecognizer) {
        if(gestureRecognizer.state == UIGestureRecognizer.State.ended ||
            gestureRecognizer.state == UIGestureRecognizer.State.changed ) {
            
            let touchPoint = gestureRecognizer.location(in: self)
            
            var smallestDistance = CGFloat(Float.infinity)
            
            var selectedIndex = 0
            
            for (index, point) in self.centers.enumerated() {
                let distance = touchPoint.distanceWith(point)
                if(distance < smallestDistance) {
                    smallestDistance = distance
                    selectedIndex = index
                }
            }
            
            
            
            if(self.selectedIndex != selectedIndex) {
				self.selectedIndex = selectedIndex
				self.setNeedsDisplay()
            }
        }
    }
    
}
*/
