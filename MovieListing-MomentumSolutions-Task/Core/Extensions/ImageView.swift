//
//  ImageView+CornerRadius.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 21/07/2025.
//

import UIKit

extension UIView {
    func setCornerRadius(_ radius: CGFloat, corners: UIRectCorner = .allCorners, clipToBounds: Bool = true) {
        let path = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        self.clipsToBounds = clipToBounds
    }
}
