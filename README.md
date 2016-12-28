# MaskableView

MaskableView is able to add any masks to UIView with Swift 3.

---

# Required

- Xcode 8.0 or later
- iOS 8.0 or later
- Carthage

---

# Install

Add `github "fromkk/MaskableView"` to **Cartfile** and execute `carthage update` command on your terminal in project directory.  

Add **Carthage/Build/{Platform}/MaskableView.framework** to **Link Binary with Libralies** in you project.  
If you doesn't use Carthage, add **New Run Script Phase** and input `/usr/local/bin/carthage copy-frameworks` in **Build Phases** tab.  
Add `$(SRCROOT)/Carthage/Build/{Platform}/MaskableView.framework` to **Input Files**.

---

# Usage

add `import MaskableView` to top of swift file.

## Simple mask

```swift
let redView: UIView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 375.0, height: 667.0)))
redView.backgroundColor = UIColor.red

let view: MaskableView = MaskableView(frame: redView.bounds)
view.backgroundColor = UIColor(white: 0.0, alpha: 0.50)

let mask: MaskableView.Mask = MaskableView.Mask(frame: CGRect(origin: CGPoint(x: 50.0, y: 50.0), size: CGSize(width: 100.0, height: 60.0)), shape: MaskableView.Mask.Shape.radius(10.0)) { (mask: MaskableView.Mask) in
    print("tapped mask1")
}

view.set(mask: mask)
redView.addSubview(view)

```

## Multiple mask

```swift
let redView: UIView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 375.0, height: 667.0)))
redView.backgroundColor = UIColor.red

let maskView: MultiMaskableView = MultiMaskableView(frame: redView.bounds)
maskView.backgroundColor = UIColor(white: 0.0, alpha: 0.50)

let mask1: MultiMaskableView.Mask = MultiMaskableView.Mask(frame: CGRect(origin: CGPoint(x: 50.0, y: 50.0), size: CGSize(width: 100.0, height: 60.0)), shape: MultiMaskableView.Mask.Shape.radius(10.0)) { (mask: MultiMaskableView.Mask) in
    print("tapped mask1")
}

maskView.add(mask: mask1)
maskView.add(maskFrame: CGRect(origin: CGPoint(x: 50.0, y: 200.0), size: CGSize(width: 50.0, height: 100.0)), shape: MultiMaskableView.Mask.Shape.radius(4.0)) { (mask: MultiMaskableView.Mask) in
    print("tapped mask 2")
}
redView.addSubview(maskView)
```

## Animation mask

```swift
let view: UIView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 375.0, height: 667.0)))
view.backgroundColor = UIColor.blue

let maskView: AnimationMaskableView = AnimationMaskableView(frame: view.bounds)
maskView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
maskView.duration = 2.0
maskView.delay = 1.0

maskView.add(from: MaskableView.Mask(frame: CGRect(origin: CGPoint(x: 50.0, y: 50.0), size: CGSize(width: 1.0, height: 1.0)), shape: MaskableView.Mask.Shape.radius(1.0)), to: MaskableView.Mask(frame: CGRect(origin: CGPoint(x: 50.0, y: 50.0), size: CGSize(width: 200.0, height: 200.0)), shape: MaskableView.Mask.Shape.radius(10.0), tap: { (mask: MaskableView.Mask) in
    print("tapped")
}))

maskView.animationCompletion = {
		    print("completion")
}
view.addSubview(maskView)
```

