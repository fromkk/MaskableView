//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import MaskableView

let redView: UIView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 375.0, height: 667.0)))
redView.backgroundColor = UIColor.red

let view: MaskableView = MaskableView(frame: redView.bounds)
view.backgroundColor = UIColor(white: 0.0, alpha: 0.50)

let mask: MaskableView.Mask = MaskableView.Mask(frame: CGRect(origin: CGPoint(x: 50.0, y: 50.0), size: CGSize(width: 100.0, height: 60.0)), shape: MaskableView.Mask.Shape.radius(10.0)) { (mask: MaskableView.Mask) in
    print("tapped mask1")
}

view.set(mask: mask)
redView.addSubview(view)

PlaygroundPage.current.liveView = redView
