//
//  TooltipView
//
//  Created by Amir Khorsandi on 2/23/17.
//  Copyright © 2017 amirdew. All rights reserved.
//

import UIKit

@objc public enum AMTooltipViewSide:Int{
    case bottom = 1
    case top = 2
    case auto = 3
}


@objc public protocol AMTooltipViewDelegate {
}


//default config

struct AMTooltipViewConfig{
    
    var side:AMTooltipViewSide = .auto
}





open class AMTooltipView: UIView {
    
    var duration:CGFloat = 4.0
    var animationShowDuration = 0.45
    var animationHideDuration = 0.55
    
    var config:AMTooltipViewConfig = AMTooltipViewConfig()
    
    var darkView:UIView!
    
    @IBOutlet weak var cutOutView: UIView!
    @IBOutlet weak var cutOutViewY: NSLayoutConstraint!
    @IBOutlet weak var cutOutViewX: NSLayoutConstraint!
    @IBOutlet weak var cutOutViewWidth: NSLayoutConstraint!
    @IBOutlet weak var cutOutViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var topDotLeftSpace: NSLayoutConstraint!
    @IBOutlet weak var messageRightSpaceFromTopDot: NSLayoutConstraint!
    
    @IBOutlet weak var bottomDotLeftSpace: NSLayoutConstraint!
    @IBOutlet weak var messageRightSpaceFromBottomDot: NSLayoutConstraint!
    
    
    @IBOutlet weak open  var topDotView: UIView!
    @IBOutlet weak open  var topDotLineView: UIView!
    @IBOutlet weak open  var messageWrapperView: UIView!
    
    @IBOutlet weak open  var bottomDotView: UIView!
    @IBOutlet weak open  var bottomDotLineView: UIView!
    @IBOutlet weak open  var bottomMessageWrapperView: UIView!
    
    
    
    @IBOutlet weak var textWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomTextWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var grayWrapper: CutOutViewWrapper!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var bottomMessageLabel: UILabel!
    
    //MARK: - properties
    open var delegate:AMTooltipViewDelegate!
    @IBOutlet weak var contentView: UIView!
    
    
    //MARK: - init
    
    fileprivate func setup(){
        loadNib()
        
        self.addSubview(contentView)
        
        self.addConstraints([
            
            NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: contentView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: contentView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
            
            ])
        
        bottomDotView.layer.borderColor = UIColor.white.cgColor
        topDotView.layer.borderColor = UIColor.white.cgColor
        
    }
    
    fileprivate func loadNib() {
        
        
        let podBundle = Bundle(for: self.classForCoder)
        
        if let bundleURL = podBundle.url(forResource: "AMTooltip", withExtension: "bundle") {
            
            if let bundle = Bundle(url: bundleURL) {
                
                bundle.loadNibNamed("AMTooltipView", owner: self, options: nil)
            }else {
                
                assertionFailure("Could not load the bundle")
            }
        }else {
            
            assertionFailure("Could not create a path to the bundle")
        }
        
        
    }
    
    
    //MARK: - init and show
    
    @discardableResult convenience public init(side:AMTooltipViewSide, message:String!, focusView:UIView, target:Any, complete:(()->())! = nil){
        
        var view:UIView!
        if let targetView = target as? UIView{ view = targetView}
        if let targetViewController = target as? UIViewController{ view = targetViewController.view}
        
        if view == nil {
            self.init(frame:.zero)
            return
        }
        
        
        var focusFrame =  (focusView.superview?.convert(focusView.frame, to: view))!
        
        focusFrame.size.width += 30
        focusFrame.size.height += 10
        
        focusFrame.origin.y -= 5
        focusFrame.origin.x -= 15
        
        self.init(side: side, message: message, focusFrame: focusFrame, target: target, complete:complete)
    }
    
    
    
    @discardableResult convenience public init(side:AMTooltipViewSide, message:String!, focusFrame:CGRect, target:Any, complete:(()->())! = nil){
        
        
        self.init(frame:.zero)
        setup()
        
        
        config.side = side
        
        
        var view:UIView!
        if let targetView = target as? UIView{ view = targetView}
        if let targetViewController = target as? UIViewController{ view = targetViewController.view}
        
        if view == nil {return}
        
        for subView in view.subviews{
            if let tooltip = subView as? AMTooltipView{
                tooltip.removeFromSuperview()
                AMTooltipView(side:side, message:message, focusFrame:focusFrame, target:target)
                return
            }
        }
        
        view.addSubview(self)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.text = message
        
        view.addConstraints([
            
            NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
            
            ])
        
        
        cutOutViewX.constant = focusFrame.origin.x
        cutOutViewY.constant = focusFrame.origin.y
        cutOutViewWidth.constant = focusFrame.size.width
        cutOutViewHeight.constant = focusFrame.size.height
        
        
        grayWrapper.cutView = cutOutView
        
        
        let tap = UITapGestureRecognizer { (gesture:UIGestureRecognizer) in
            
            self.hide(complete)
        }
        
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        grayWrapper.addGestureRecognizer(tap)
        
        
        self.show()
        
        
    }
    
    
    
    func show(){
        
        
        
        
        self.alpha = 0
        textWidthConstraint.constant = 270
        bottomTextWidthConstraint.constant  = textWidthConstraint.constant
        self.layoutIfNeeded()
        
        
        if config.side == .auto {
            
            config.side = .bottom
            
            if messageWrapperView.frame.origin.y > 10{
                config.side = .top
            }
            
            
        }
        
        let message = messageLabel.text
        messageLabel.text = ""
        bottomMessageLabel.text = ""
        self.layoutIfNeeded()
        
        
        
        topDotLeftSpace.constant = grayWrapper.cutView.frame.size.width/2
        bottomDotLeftSpace.constant = topDotLeftSpace.constant
        messageRightSpaceFromTopDot.constant = -textWidthConstraint.constant/2-6
        messageRightSpaceFromBottomDot.constant = -messageRightSpaceFromTopDot.constant+4
        
        
        
        topDotView.isHidden = config.side != .top
        topDotLineView.isHidden = config.side != .top
        messageWrapperView.isHidden = config.side != .top
        
        bottomDotView.isHidden = config.side != .bottom
        bottomDotLineView.isHidden = config.side != .bottom
        bottomMessageWrapperView.isHidden = config.side != .bottom
        
        
        messageLabel.text = message
        bottomMessageLabel.text = message
        
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
            self.layoutIfNeeded()
        }) { (finished:Bool) in
            
        }
        
    }
    
    
    open func hide(_ complete: (()->())! = nil){
        
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { (finished:Bool) in
            self.removeFromSuperview()
            if complete != nil{
                complete()
            }
        }
        
    }
    
}

//MARK: -


class CutOutViewWrapper:UIView{
    
    
    open var cutView:UIView!
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        
        if let context: CGContext = UIGraphicsGetCurrentContext() {
            context.setBlendMode(.destinationOut)
            
            let path: UIBezierPath = UIBezierPath(roundedRect: cutView.frame, cornerRadius: cutView.layer.cornerRadius)
            path.fill()
            
            context.setBlendMode(.normal)
        }
    }
    
}


//MARK: -



extension UIGestureRecognizer{
    
    public typealias ActionClosure = (_ gesture: UIGestureRecognizer) -> Void
    
    fileprivate struct AssociatedKeys {
        static var actionClosure:ActionClosure?
    }
    
    var actionClosure: Any? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.actionClosure)
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.actionClosure, newValue as Any?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    
    public convenience init(_ closure:@escaping ActionClosure) {
        
        self.init()
        self.addTarget(self, action: #selector(handelAction))
        self.actionClosure = closure
        
    }
    
    
    func handelAction(_ gesture:UIGestureRecognizer){
        if let actionClosure = self.actionClosure as? ActionClosure{
            actionClosure(gesture)
        }
    }
}



