//
//  DarkOverlayView.swift
//  PullToRefreshTableView
//
//  Created by Reid Cooper on 4/27/17.
//  Copyright © 2017 Reid Cooper. All rights reserved.
//

import UIKit

class DarkOverlayView: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.clear
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    backgroundColor = UIColor.clear
  }

  override func draw(_ rect: CGRect) {
    let components: [CGFloat] = [0, 0, 0, 0.1]
    let locations: [CGFloat] = [0]
    // 2
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let gradient = CGGradient(colorSpace: colorSpace, colorComponents: components, locations: locations, count: 1)
    
    let startPoint = CGPoint(x: bounds.minX, y: bounds.minY)
    let endPoint = CGPoint(x: bounds.maxX, y: bounds.maxY)
    
    let context = UIGraphicsGetCurrentContext()
    context?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: .drawsAfterEndLocation)
  }
}

/*
 
 The drawing code uses the Core Graphics framework (also known as Quartz 2D). It may look a little scary but this is what it does:
 1. Firstyoucreatetwoarraysthatcontainthe“colorstops”forthegradient.The first color (0, 0, 0, 0.3) is a black color that is mostly transparent. It sits at location 0 in the gradient, which represents the center of the screen because you’ll be drawing a circular gradient.
 The second color (0, 0, 0, 0.7) is also black but much less transparent and sits at location 1, which represents the circumference of the gradient’s circle. Remember that in UIKit and also in Core Graphics, colors and opacity values don’t go from 0 to 255 but are fractional values between 0.0 and 1.0.
 The 0 and 1 from the locations array represent percentages: 0% and 100%, respectively. If you have more than two colors, you can specify the percentages of where in the gradient you want to place these colors.
 2. Withthosecolorstopsyoucancreatethegradient.Thisgivesyouanew CGGradient object.
 3. Nowthatyouhavethegradientobject,youhavetofigureouthowbigyouneed to draw it. The midX and midY properties return the center point of a rectangle. That rectangle is given by bounds, a CGRect object that describes the dimensions of the view.
 If I can avoid it, I prefer not to hard-code any dimensions such as “320 by 568 points”. By asking bounds, you can use this view anywhere you want to, no matter how big a space it should fill. You can use it without problems on any screen size from the smallest iPhone to the biggest iPad.
 The centerPoint constant contains the coordinates for the center point of the view and radius contains the larger of the x and y values; max() is a handy function that you can use to determine which of two values is the biggest.
 4. Withallthosepreliminariesdone,youcanfinallydrawthething.CoreGraphics drawing always takes places in a so-called graphics context. We’re not going to worry about exactly what that is, just know that you need to obtain a reference to the current context and then you can do your drawing.
 And finally, the drawRadialGradient() function draws the gradient according to your specifications.
 It generally speaking isn’t optimal to create new objects inside your draw() method, such as gradients, especially if draw() is called often. In that case it is better to create the objects the first time you need them and to reuse the same instance over and over (lazy loading!).
 However, you don’t really have to do that here because this draw() method will be called just once – when the DetailViewController gets loaded – so you can get away with being less than optimal.
 
*/
