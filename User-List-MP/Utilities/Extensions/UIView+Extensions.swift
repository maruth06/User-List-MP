//
//  UIView+Extensions.swift
//  Users-Miho
//
//  Created by Mac on 9/9/20.
//  Copyright © 2020 Miho. All rights reserved.
//

import UIKit

extension UIView {
    
    func roundView(withBorderColor color: UIColor? = nil, withBorderWidth width: CGFloat? = nil) {
        self.setCornerRadius(radius: min(self.frame.size.height, self.frame.size.width) / 2)
        self.layer.borderWidth = width ?? 0
        self.layer.borderColor = color?.cgColor ?? UIColor.clear.cgColor
    }
    
    public func nakedView() {
        self.layer.mask = nil
        self.layer.borderWidth = 0
    }
    
    public func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func startShimmerAnimation() {
        let gradientColorOne : CGColor = UIColor(white: 0.85, alpha: 1.0).cgColor
        let gradientColorTwo : CGColor = UIColor(white: 0.95, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        /* Allocate the frame of the gradient layer as the view's bounds, since the layer will sit on top of the view. */
        
        gradientLayer.frame = self.bounds
        /* To make the gradient appear moving from left to right, we are providing it the appropriate start and end points.
         Refer to the diagram above to understand why we chose the following points.
         */
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = 1.0
        
        gradientLayer.add(animation, forKey: animation.keyPath)
        
        /* Adding the gradient layer on to the view */
        self.layer.addSublayer(gradientLayer)
    }
    
    private var container: UIView {
        return UIView()
    }
    
    func showLoading() {
        container.frame = self.frame
        container.center = self.center
        container.backgroundColor = UIColor(rgb: 0xffffff, alpha: 0.3)

        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = self.center
        loadingView.backgroundColor = UIColor(rgb:0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10

        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        actInd.style = UIActivityIndicatorView.Style.large
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        self.addSubview(container)
        actInd.startAnimating()
    }
    
    func dismissLoading() {
        container.removeFromSuperview()
    }
}

final class Spinner {
    
    fileprivate static var activityIndicator: UIActivityIndicatorView?
    fileprivate static var style: UIActivityIndicatorView.Style = .large
    fileprivate static var baseBackColor = UIColor(white: 0, alpha: 0.6)
    fileprivate static var baseColor = UIColor.white
    
    /**
     Add spinner to `UIView`
     
     - Parameters:
     - view: The `UIView` being used to add the `UIActivityIndicatorView` onto
     - style: Style used for the `UIActivityIndicatorView`
     - backgroundColor: Display color
     - baseColor: Tint color of the spinner
     */
    public static func start(from view: UIView,
                             style: UIActivityIndicatorView.Style = Spinner.style,
                             backgroundColor: UIColor = Spinner.baseBackColor,
                             baseColor: UIColor = Spinner.baseColor) {
        
        guard Spinner.activityIndicator == nil else { return }
        DispatchQueue.main.async {
            let spinner = UIActivityIndicatorView(style: style)
            spinner.backgroundColor = backgroundColor
            spinner.color = baseColor
            spinner.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(spinner)
            
            // Auto-layout constraints
            addConstraints(to: view, with: spinner)
            
            Spinner.activityIndicator = spinner
            Spinner.activityIndicator?.startAnimating()
        }
    }
    
    /// Stops and removes `UIActivityIndicatorView`
    public static func stop() {
        DispatchQueue.main.async {
            Spinner.activityIndicator?.stopAnimating()
            Spinner.activityIndicator?.removeFromSuperview()
            Spinner.activityIndicator = nil
        }
    }
    
    /**
     Add auto-layout constraints to provided `UIActivityIndicatorView`
     
     - Parameters:
     - view: The view used to provide layout constraints
     - spinner: The `UIActivityIndicatorView` used to display
     */
    fileprivate static func addConstraints(to view: UIView, with spinner: UIActivityIndicatorView) {
        spinner.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        spinner.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        spinner.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        spinner.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
}
