//
//  FloatingLabelTextField.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 31.03.2022.
//

// swiftlint:disable all
open class FloatingLabelTextField: UITextField {
    
    public enum Step {
        case editing
        case notEditing
    }
    
    fileprivate var step: Step = .notEditing {
        didSet {
            self.animatePlaceholderIfNeeded(with: step)
        }
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.size(.init(width: 18, height: 18))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .appCinder
        return imageView
    }()
    
    public var leftImage: UIImage? {
        willSet {
            if let image = newValue {
                imageView.image = image.withRenderingMode(.alwaysTemplate)
                leftView = imageView
                leftViewMode = .always
            } else {
                imageView.image = nil
                leftView = nil
                leftViewMode = .never
            }
        }
    }
    
    public override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x = 15
        rect.origin.y = 21
        return rect
    }
    
    private var insets: UIEdgeInsets {
        var insets = UIEdgeInsets(top: 29, left: 25, bottom: 12, right: 15)
        if let leftView = leftView {
            insets.left += leftView.bounds.width
        }
        return insets
    }
    
    fileprivate weak var lmdPlaceholder: UILabel!
    fileprivate let textRectYInset : CGFloat = 7
    fileprivate var editingConstraints = [NSLayoutConstraint]()
    fileprivate var notEditingConstraints : [NSLayoutConstraint]!
    fileprivate var activeConstraints : [NSLayoutConstraint]!
    
    // MARK: - PUBLIC VARIABLES
    public var placeholderFont = UIFont.font(.nunitoBold, size: .large) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    open override var text: String? {
        didSet {
            self.animatePlaceholderIfNeeded(with: self.step)
        }
    }
    
    @IBInspectable public var placeholderText: String? {
        didSet {
            self.lmdPlaceholder.text = placeholderText
            self.animatePlaceholderIfNeeded(with: self.step)
        }
    }
    
    @IBInspectable public var placeholderSizeFactor: CGFloat = 0.857  {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var themeColor: UIColor? = UIColor(red: 1, green: 0, blue: 131/255, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var borderColor: UIColor? = .appRed {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var errorBorderColor: UIColor? = UIColor(red: 1, green: 0, blue: 131/255, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var placeholderTextColor: UIColor = .appHeather {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var textFieldTextColor: UIColor = .appRaven {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var disabledTextColor: UIColor = UIColor(white: 183/255, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var disabledBackgroundColor: UIColor = UIColor(white: 247/255, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var enabledBackgroundColor: UIColor = .white {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    public var disabled = false {
        didSet {
            self.updateStep(.notEditing)
        }
    }
    
    public var error = false {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var topPadding: CGFloat = 6
    
    //MARK: - LIFE CYCLE
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupViews()
    }
    
    fileprivate func setupViews() {
        self.height(60)
        
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2
        
        self.addTarget(self, action: #selector(editingDidBegin), for: UIControl.Event.editingDidBegin)
        self.addTarget(self, action: #selector(editingDidEnd), for: UIControl.Event.editingDidEnd)
        
        let placeholder = UILabel()
        
        placeholder.layoutMargins = .zero
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            placeholder.insetsLayoutMarginsFromSafeArea = false
        }
        self.addSubview(placeholder)
        
        self.lmdPlaceholder = placeholder
        
        self.notEditingConstraints = [
            NSLayoutConstraint(item: self.lmdPlaceholder, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: self.insets.left + 15),
            NSLayoutConstraint(item: self.lmdPlaceholder, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        ]
        NSLayoutConstraint.activate(self.notEditingConstraints)
        self.activeConstraints = self.notEditingConstraints
        self.setNeedsLayout()
    }
    
    fileprivate func calculateEditingConstraints() {
        let attributedStringPlaceholder = NSAttributedString(string: (self.placeholderText ?? ""), attributes: [
            NSAttributedString.Key.font : self.placeholderFont
            ])
        let originalWidth = attributedStringPlaceholder.boundingRect(with: CGSize(width: .greatestFiniteMagnitude, height: self.frame.height), options: [], context: nil).width
        
        let xOffset = (originalWidth - (originalWidth * placeholderSizeFactor)) / 2
        
        self.editingConstraints = [
            NSLayoutConstraint(item: self.lmdPlaceholder, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: -xOffset + self.insets.left),
            NSLayoutConstraint(item: self.lmdPlaceholder, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: self.topPadding)
        ]
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.tintColor = themeColor
        self.lmdPlaceholder.font = self.placeholderFont
        self.lmdPlaceholder.textColor = self.placeholderTextColor
        self.lmdPlaceholder.text = self.placeholderText
        self.textColor = self.disabled ? self.disabledTextColor : self.textFieldTextColor
        self.font = .font(.nunitoSemiBold, size: .large)
        self.backgroundColor = self.disabled ? self.disabledBackgroundColor : self.enabledBackgroundColor
        self.layer.borderColor = self.error ? self.errorBorderColor?.cgColor : self.step == .editing ? self.borderColor?.cgColor : UIColor.appZircon.cgColor
        self.isEnabled = !self.disabled
    }
    
    fileprivate func animatePlaceholderIfNeeded(with step: Step) {
        
        switch step {
        case .editing:
            self.animatePlaceholderToActivePosition()
            placeholderTextColor = .appRed
        case .notEditing:
            if (self.text ?? "").isEmpty {
                self.animatePlaceholderToInactivePosition()
                placeholderTextColor = .appHeather
            } else {
                self.animatePlaceholderToActivePosition()
            }
        }
        self.setNeedsLayout()
    }
    
    fileprivate func animatePlaceholderToActivePosition(animated: Bool = true) {
        self.calculateEditingConstraints()
        self.layoutIfNeeded()
        NSLayoutConstraint.deactivate(self.activeConstraints)
        NSLayoutConstraint.activate(self.editingConstraints)
        self.activeConstraints = self.editingConstraints
        
        let animationBlock = {
            self.layoutIfNeeded()
            self.lmdPlaceholder.transform = CGAffineTransform(scaleX: self.placeholderSizeFactor, y: self.placeholderSizeFactor)
        }
        if animated {
            UIView.animate(withDuration: 0.2) {
                animationBlock()
            }
        } else {
            animationBlock()
        }
    }
    
    fileprivate func animatePlaceholderToInactivePosition(animated: Bool = true) {
        self.layoutIfNeeded()
        NSLayoutConstraint.deactivate(self.activeConstraints)
        NSLayoutConstraint.activate(self.notEditingConstraints)
        self.activeConstraints = self.notEditingConstraints
        let animationBlock = {
            self.layoutIfNeeded()
            self.lmdPlaceholder.transform = .identity
        }
        if animated {
            UIView.animate(withDuration: 0.2) {
                animationBlock()
            }
        } else {
            animationBlock()
        }
    }
    
    @objc private func editingDidBegin() {
        self.step = .editing
    }
    
    @objc private func editingDidEnd() {
        self.step = .notEditing
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        return self.calculateTextRect(forBounds: bounds)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        return self.calculateTextRect(forBounds: bounds)
    }
    
    fileprivate func calculateTextRect(forBounds bounds: CGRect) -> CGRect {
        let textInset = (self.placeholderText ?? "").isEmpty == true ? 0 : self.textRectYInset
        return CGRect(x: insets.left,
                      y: textInset,
                      width: bounds.width - (insets.left * 2),
                      height: bounds.height)
    }
    
    // MARK: - PUBLIC FUNCTIONS
    public func updateStep(_ step: Step) {
        self.step = step
    }
}
