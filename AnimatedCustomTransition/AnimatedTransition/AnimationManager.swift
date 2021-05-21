//
//  CircularTransition.swift
//  CircularTransition
//
//  Created by Training on 26/08/2016.
//  Copyright © 2016 Training. All rights reserved.
//
import UIKit


class AnimationManager: NSObject {
    
    var circle = UIView()
    
    var startingPoint = CGPoint.zero {
        didSet {
            circle.center = startingPoint
        }
    }
    
    var circleColor = UIColor.white
    
    var duration = 0.5
    
    enum TransitionMode:Int {
        case present, dismiss, pop
    }
    
    enum TransitionStyle:Int {
        case circle, squre, scale
    }
    
    var transitionMode:TransitionMode = .present
    var transitionStyle:TransitionStyle = .scale
    
}

extension AnimationManager:UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch transitionMode {
        case .present:
            presentAnimation(with: transitionContext)
        case .dismiss, .pop:
            dismissAnimation(with: transitionContext)
        }
    }
    
}

extension AnimationManager{
    
    private func frameForCircle (withViewCenter viewCenter:CGPoint, size viewSize:CGSize, startPoint:CGPoint) -> CGRect {
        let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        
        let offestVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offestVector, height: offestVector)
        
        return CGRect(origin: CGPoint.zero, size: size)
        
    }
    
    private func presentAnimation(with transitionContext:UIViewControllerContextTransitioning){
        
        let containerView = transitionContext.containerView
        guard let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        else { return }
        
        
        if transitionStyle == .scale {
            presentedView.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
            presentedView.center = containerView.center
            containerView.addSubview( presentedView)
            
            UIView.animate(withDuration: duration, animations: { [weak self] in
                guard self != nil else { return }
                presentedView.transform = CGAffineTransform.identity
            }, completion: { [weak self] (success:Bool) in
                guard self != nil else { return }
                transitionContext.completeTransition(success)
            })
            return
        }
        
        let viewCenter = presentedView.center
        let viewSize = presentedView.frame.size

        circle = UIView()

        circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)

        if transitionStyle == .circle {
            circle.layer.cornerRadius = circle.frame.size.height / 2
        }
        circle.center = startingPoint
        circle.backgroundColor = circleColor
        circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        containerView.addSubview(circle)


        presentedView.center = startingPoint
        presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        presentedView.alpha = 0
        containerView.addSubview(presentedView)

        UIView.animate(withDuration: duration, animations: { [weak self] in
            guard let self = self else { return }
            self.circle.transform = CGAffineTransform.identity
            presentedView.transform = CGAffineTransform.identity
            presentedView.alpha = 1
            presentedView.center = viewCenter
        }, completion: { [weak self] (success:Bool) in
            guard self != nil else { return }
            transitionContext.completeTransition(success)
        })
    }
    
    private func dismissAnimation(with  transitionContext:UIViewControllerContextTransitioning){
        let containerView = transitionContext.containerView
        let transitionModeKey = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
        
        guard let returningView = transitionContext.view(forKey: transitionModeKey)
        else { return }
        
        
        if transitionStyle == .scale {
            returningView.center = containerView.center
            containerView.addSubview( returningView)
    
//            UIView.animate(withDuration: 2) {
//                returningView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3).concatenating(CGAffineTransform(translationX: -containerView.bounds.width, y: containerView.bounds.height))
//            } completion: { [weak self] (success:Bool) in
//                guard self != nil else { return }
//                transitionContext.completeTransition(success)
//            }

            
            UIView.animateKeyframes(withDuration: duration + 0.5, delay: 0, options: .calculationModeLinear) { [weak self] in
                guard self != nil else { return }
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.7) {
                    returningView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
                }
                UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 1.0) {
                    returningView.transform = returningView.transform.concatenating(CGAffineTransform(translationX: -containerView.bounds.width, y: 0))

                }
            } completion: { [weak self] (success:Bool) in
                guard self != nil else { return }
                transitionContext.completeTransition(success)
            }
            return
        }
        
        let viewCenter = returningView.center
        let viewSize = returningView.frame.size
        
        
        circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
        
        if transitionStyle == .circle {
            circle.layer.cornerRadius = circle.frame.size.height / 2
        }
        circle.center = startingPoint
        
        UIView.animate(withDuration: duration, animations: { [weak self] in
            guard let self = self else { return }
            self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            returningView.center = self.startingPoint
            returningView.alpha = 0
            
            if self.transitionMode == .pop {
                containerView.insertSubview(returningView, belowSubview: returningView)
                containerView.insertSubview(self.circle, belowSubview: returningView)
            }
        }, completion: { [weak self] (success:Bool) in
            guard let self = self else { return }
            returningView.center = viewCenter
            returningView.removeFromSuperview()
            self.circle.removeFromSuperview()
            transitionContext.completeTransition(success)
        })
    }
    
}
