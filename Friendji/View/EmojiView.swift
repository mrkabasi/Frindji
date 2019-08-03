//
//  EmojiView.swift
//  Friendji
//
//  Created by Kasra Abasi on 8/2/19.
//  Copyright © 2019 kasraabasi. All rights reserved.
//

/// This class is inspire from a stanford university class

/// This is a subclass of UIView responsible for drawing an emoji, it use UIBezierPath for drawing graphics

import UIKit

@IBDesignable
class EmojiView: UIView {
    
    // MARK: - Properties
    @IBInspectable var size: CGFloat = 0.9 { didSet { setNeedsDisplay() } }
    @IBInspectable var mouthCurvature: Double = 0 { didSet { setNeedsDisplay() } } // 1 full smile, -1 full frown
    @IBInspectable var isEyesOpen: Bool = true { didSet { setNeedsDisplay() } }
    @IBInspectable var eyeBrowTilt: Double = 0 { didSet { setNeedsDisplay() } } // 1 fuul relax, -1 full frown
    @IBInspectable var color: UIColor = .black { didSet { setNeedsDisplay() } }
    @IBInspectable var lineWidth: CGFloat = 2.0 { didSet { setNeedsDisplay() } }
    
    
    
    // MARK: - Overrides
    override func draw(_ rect: CGRect) {
        color.set()
        pathForCircleCenteredAtPoint(skullCenter, withRadius: skullRadius).stroke()
        pathForEye(.left).stroke()
        pathForEye(.right).stroke()
        pathForMouth().stroke()
        pathForBrow(.left).stroke()
        pathForBrow(.right).stroke()
    }

}



// MARK: - Private Extension
private extension EmojiView {
    
    // MARK: - Inner Types
    enum Eye {
        case left
        case right
    }
    
    
    
    // MARK: - Properties
    var skullRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * size
    }
    var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    
    
    // MARK: - Methods
    func pathForCircleCenteredAtPoint(_ midPoint: CGPoint, withRadius radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath(
            arcCenter: midPoint,
            radius: radius,
            startAngle: 0.0,
            endAngle: CGFloat(2 * Double.pi),
            clockwise: false
        )
        path.lineWidth = lineWidth
        path.lineCapStyle = .round
        return path
    }
    func getEyeCenter(_ eye: Eye) -> CGPoint {
        let eyeOffset = skullRadius / Constant.Number.skullRadiusToEyeOffset
        var eyeCenter = skullCenter
        eyeCenter.y -= eyeOffset
        switch eye {
        case .left: eyeCenter.x -= eyeOffset
        case .right: eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }
    func pathForEye(_ eye: Eye) -> UIBezierPath {
        let eyeRadius = skullRadius / Constant.Number.skullRadiusToEyeRadus
        let eyeCenter = getEyeCenter(eye)
        if isEyesOpen {
            return pathForCircleCenteredAtPoint(eyeCenter, withRadius: eyeRadius)
        } else {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
            path.lineWidth = lineWidth
            path.lineCapStyle = .round
            return path
        }
    }
    func pathForMouth() -> UIBezierPath {
        let mouthWidth = skullRadius / Constant.Number.skullRadiusToMouthWidth
        let mouthHeith = skullRadius / Constant.Number.skullRadiusToMouthHeight
        let mouthOffset = skullRadius / Constant.Number.skullRadiusToMouthOffset
        let mouthRect = CGRect(x: skullCenter.x - mouthWidth/2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeith)
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
        let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        path.lineCapStyle = .round
        return path
    }
    func pathForBrow(_ eye: Eye) -> UIBezierPath {
        var tilt = eyeBrowTilt
        switch eye {
        case .left: tilt *= -1.0
        case .right: break
        }
        var browCenter = getEyeCenter(eye)
        browCenter.y -= skullRadius / Constant.Number.skullRadiusToBrowOffset
        let eyeRadius = skullRadius / Constant.Number.skullRadiusToEyeRadus
        let tiltOffset = CGFloat(max(-1, min(tilt, 1))) * eyeRadius / 2
        let browStart = CGPoint(x: browCenter.x - eyeRadius, y: browCenter.y - tiltOffset)
        let browEnd = CGPoint(x: browCenter.x + eyeRadius, y: browCenter.y + tiltOffset)
        let path = UIBezierPath()
        path.move(to: browStart)
        path.addLine(to: browEnd)
        path.lineWidth = lineWidth
        path.lineCapStyle = .round
        return path
    }
}
