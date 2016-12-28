//
//  MultiMaskableView.swift
//  MaskableView
//
//  Created by Kazuya Ueoka on 2016/12/28.
//
//

import UIKit
import CoreGraphics

open class MultiMaskableView: MaskableView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func add(mask: MaskableView.Mask) {
        mask.change = { [weak self] (mask: MaskableView.Mask) in
            self?.makeMaskLayer()
        }
        self.masks.append(mask)
        self.makeMaskLayer()
    }

    public func add(maskFrame frame: CGRect, shape: Mask.Shape = Mask.Shape.rect, tap: Mask.Tap? = nil) {
        let mask: Mask = Mask(frame: frame, shape: shape, tap: tap)
        mask.change = { [weak self] (mask: Mask) in
            self?.makeMaskLayer()
        }
        self.masks.append(mask)
        self.makeMaskLayer()
    }
}
