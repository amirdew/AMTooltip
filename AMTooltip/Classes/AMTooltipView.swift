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


public class AMTooltipViewOptions{
    
    
    var side:AMTooltipViewSide!
    var textColor:UIColor!
    var textWidth:CGFloat!
    var font:UIFont!
    var textAlignment:NSTextAlignment!
    var textBoxBackgroundColor:UIColor!
    var textBoxCornerRadius:CGFloat!
    var textBoxBorderColor:UIColor!
    var textBoxBorderWidth:CGFloat!
    var addOverlayView:Bool = true
    var overlayBackgroundColor:UIColor!
    var lineColor:UIColor!
    var lineWidth:CGFloat!
    var lineHeight:CGFloat!
    var dotColor:UIColor!
    var dotSize:CGFloat!
    var dotBorderWidth:CGFloat!
    var dotBorderColor:UIColor!
    var focusViewRadius:CGFloat!
    var focustViewVerticalPadding:CGFloat!
    var focustViewHorizontalPadding:CGFloat!
    
    
    
    public init(
        side:AMTooltipViewSide = .auto,
        textColor:UIColor = UIColor.black,
        textWidth:CGFloat = 270,
        font:UIFont = UIFont.systemFont(ofSize: 14),
        textAlignment:NSTextAlignment = .natural,
        textBoxBackgroundColor:UIColor = UIColor.white,
        textBoxCornerRadius:CGFloat = 6,
        textBoxBorderColor:UIColor = UIColor.clear,
        textBoxBorderWidth:CGFloat = 0,
        addOverlayView:Bool = true,
        overlayBackgroundColor:UIColor = UIColor.black.withAlphaComponent(0.4),
        lineColor:UIColor = UIColor.white,
        lineWidth:CGFloat = 2,
        lineHeight:CGFloat = 30,
        dotColor:UIColor = UIColor.lightGray,
        dotSize:CGFloat = 13,
        dotBorderWidth:CGFloat = 2,
        dotBorderColor:UIColor = UIColor.white,
        focusViewRadius:CGFloat = 6,
        focustViewVerticalPadding:CGFloat = 5,
        focustViewHorizontalPadding:CGFloat = 15
        ){
     
        self.side = side
        self.textColor = textColor
        self.textWidth = textWidth
        self.font = font
        self.textAlignment = textAlignment
        self.textBoxBackgroundColor = textBoxBackgroundColor
        self.textBoxCornerRadius = textBoxCornerRadius
        self.textBoxBorderColor = textBoxBorderColor
        self.textBoxBorderWidth = textBoxBorderWidth
        self.addOverlayView = addOverlayView
        self.overlayBackgroundColor = overlayBackgroundColor
        self.lineColor = lineColor
        self.lineWidth = lineWidth
        self.lineHeight = lineHeight
        self.dotColor = dotColor
        self.dotSize = dotSize
        self.dotBorderWidth = dotBorderWidth
        self.dotBorderColor = dotBorderColor
        self.focusViewRadius = focusViewRadius
        self.focustViewVerticalPadding = focustViewVerticalPadding
        self.focustViewHorizontalPadding = focustViewHorizontalPadding
         
        
    }
    
    
}





open class AMTooltipView: UIView {
    
    
    var options:AMTooltipViewOptions!
    
    
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
    
    
    
    @IBOutlet weak var topDotLineWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var topDotLineHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topDotViewSizeConstraint: NSLayoutConstraint!
    @IBOutlet weak open  var topDotView: UIView!
    @IBOutlet weak open  var topDotLineView: UIView!
    @IBOutlet weak open  var messageWrapperView: UIView!
    
    
    @IBOutlet weak var bottomDotLineWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomDotLineHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bottomDotViewSizeConstraint: NSLayoutConstraint!
    @IBOutlet weak open  var bottomDotView: UIView!
    @IBOutlet weak open  var bottomDotLineView: UIView!
    @IBOutlet weak open  var bottomMessageWrapperView: UIView!
    
    
    
    @IBOutlet weak var textWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomTextWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var grayWrapper: CutOutViewWrapper!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var bottomMessageLabel: UILabel!
    
    
    var completeClosure:(()->())!
    
    
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
    
    
    @discardableResult convenience public init(options:AMTooltipViewOptions = AMTooltipViewOptions(), message:String!, focusView:UIView, target:Any, complete:(()->())! = nil){
        
        var view:UIView!
        if let targetView = target as? UIView{ view = targetView}
        if let targetViewController = target as? UIViewController{ view = targetViewController.view}
        
        if view == nil {
            self.init(frame:.zero)
            return
        }
        
        
        var focusFrame =  (focusView.superview?.convert(focusView.frame, to: view))!
        
        
        
        focusFrame.size.width += options.focustViewHorizontalPadding * 2
        focusFrame.size.height += options.focustViewVerticalPadding * 2
        
        focusFrame.origin.y -= options.focustViewVerticalPadding
        focusFrame.origin.x -= options.focustViewHorizontalPadding
        
        
        self.init(options: options, message: message, focusFrame: focusFrame, target: target, complete:complete)
    }
    
    
    
    @discardableResult convenience public init(options:AMTooltipViewOptions = AMTooltipViewOptions(), message:String!, focusFrame:CGRect, target:Any, complete:(()->())! = nil){
        
        
        self.init(frame:.zero)
        setup()
        self.options = options
        applyOptions()
        
        
        var view:UIView!
        if let targetView = target as? UIView{ view = targetView}
        if let targetViewController = target as? UIViewController{ view = targetViewController.view}
        
        if view == nil {return}
        
        for subView in view.subviews{
            if let tooltip = subView as? AMTooltipView{
                tooltip.removeFromSuperview()
                AMTooltipView(options:options, message:message, focusFrame:focusFrame, target:target)
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
        
        if !self.options.addOverlayView {
            grayWrapper.backgroundColor = UIColor.clear
        }
        
        completeClosure = complete
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideByTapGesture))
        
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        grayWrapper.addGestureRecognizer(tap)
        
        
        self.show()
        
        
    }
    
    
    func hideByTapGesture(){
    
        self.hide(completeClosure)
    
    }
    
    
    
    func applyOptions(){
    
        
        
        messageLabel.textColor = self.options.textColor
        messageLabel.font = self.options.font
        messageLabel.textAlignment = self.options.textAlignment
        messageWrapperView.backgroundColor = self.options.textBoxBackgroundColor
        messageWrapperView.layer.cornerRadius = self.options.textBoxCornerRadius
        messageWrapperView.layer.borderColor = self.options.textBoxBorderColor.cgColor
        messageWrapperView.layer.borderWidth = self.options.textBoxBorderWidth
        topDotLineView.backgroundColor = self.options.lineColor
        topDotLineWidthConstraint.constant = self.options.lineWidth
        topDotLineHeightConstraint.constant = self.options.lineHeight
        topDotView.backgroundColor = self.options.dotColor
        topDotViewSizeConstraint.constant = self.options.dotSize
        topDotView.layer.borderWidth = self.options.dotBorderWidth
        topDotView.layer.borderColor = self.options.dotBorderColor.cgColor
        
        
        
        bottomMessageLabel.textColor = self.options.textColor
        bottomMessageLabel.font = self.options.font
        bottomMessageLabel.textAlignment = self.options.textAlignment
        bottomMessageWrapperView.backgroundColor = self.options.textBoxBackgroundColor
        bottomMessageWrapperView.layer.cornerRadius = self.options.textBoxCornerRadius
        bottomMessageWrapperView.layer.borderColor = self.options.textBoxBorderColor.cgColor
        bottomMessageWrapperView.layer.borderWidth = self.options.textBoxBorderWidth
        bottomDotLineView.backgroundColor = self.options.lineColor
        bottomDotLineWidthConstraint.constant = self.options.lineWidth
        bottomDotLineHeightConstraint.constant = self.options.lineHeight
        bottomDotView.backgroundColor = self.options.dotColor
        bottomDotViewSizeConstraint.constant = self.options.dotSize
        bottomDotView.layer.borderWidth = self.options.dotBorderWidth
        bottomDotView.layer.borderColor = self.options.dotBorderColor.cgColor
        
        
        
        cutOutView.layer.cornerRadius = self.options.focusViewRadius
        grayWrapper.backgroundColor = self.options.overlayBackgroundColor
        
    }
    
    
    
    func show(){
        
        
        
        self.alpha = 0
        textWidthConstraint.constant = options.textWidth
        bottomTextWidthConstraint.constant  = textWidthConstraint.constant
        self.layoutIfNeeded()
        
        
        if options.side == .auto {
            
            options.side = .bottom
            
            if messageWrapperView.frame.origin.y > 10{
                options.side = .top
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
        
        
        
        topDotView.isHidden = options.side != .top
        topDotLineView.isHidden = options.side != .top
        messageWrapperView.isHidden = options.side != .top
        
        bottomDotView.isHidden = options.side != .bottom
        bottomDotLineView.isHidden = options.side != .bottom
        bottomMessageWrapperView.isHidden = options.side != .bottom
        
        
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

 


