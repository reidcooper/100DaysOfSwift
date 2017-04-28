//
//  BounceAnimationController.swift
//  PullToRefreshTableView
//
//  Created by Reid Cooper on 4/27/17.
//  Copyright © 2017 Reid Cooper. All rights reserved.
//

import UIKit

class BounceAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.4
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    // transitionContext
    // gives you a reference to new view controller and lets you know how big it should be.
    
    if let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to), let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
      
      let containerView = transitionContext.containerView
      toView.frame = transitionContext.finalFrame(for: toViewController)
      containerView.addSubview(toView)
      toView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
      
      UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .calculationModeCubic, animations: {
        
        UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.334, animations: {
          toView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        })
        
        UIView.addKeyframe(withRelativeStartTime: 0.334, relativeDuration: 0.333, animations: {
          toView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        })
        
        UIView.addKeyframe(withRelativeStartTime: 0.666, relativeDuration: 0.333, animations: {
          toView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
        
      }, completion: {
        finished in
        
        transitionContext.completeTransition(finished)
        
      })
      
    }
    
  }
}

/*

 The actual animation starts at the line UIView.animateKeyframes(...). This works like all UIView-based animation: you set the initial state before the animation block, and UIKit will automatically animate any properties that get changed inside the closure. The difference with before is that a keyframe animation lets you animate the view in several distinct stages.
 The property you’re animating is the transform. If you’ve ever taken any matrix math you’ll be pleased – or terrified! – to hear that this is an affine transformation matrix. It allows you to do all sorts of funky stuff with the view, such as rotating or shearing it, but the most common use of the transform is for scaling.
 The animation consists of several keyframes. It will smoothly proceed from one keyframe to the next over a certain amount of time. Because you’re animating the view’s scale, the different toView.transform values represent how much bigger or smaller the view will be over time.
 The animation starts with the view scaled down to 70% (scale 0.7). The next keyframe inflates it to 120% its normal size. After that, it will scale the view down a bit again but not as much as before (only 90% of its original size). The final keyframe ends up with a scale of 1.0, which restores the view to an undistorted shape.
 By quickly changing the view size from small to big to small to normal, you create a bounce effect.
 You also specify the duration between the successive keyframes. In this case, each transition from one keyframe to the next takes 1/3rd of the total animation time. These times are not in seconds but in fractions of the animation’s total duration (0.4 seconds).
 Feel free to mess around with the animation code. No doubt you can make it much more spectacular!
 To make this animation happen you have to tell the app to use the new animation controller when presenting the Detail pop-up. That happens in the transitioning delegate inside DetailViewController.swift.

 
*/
