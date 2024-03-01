//
//  CustomTextView.swift
//  CollectionViewDemo
//
//  Created by Sefa Aycicek on 1.03.2024.
//

import UIKit


protocol CustomButtonInteractionProtocol {
    func alternativeClick() 
}

@IBDesignable
open class MaterialBorderedTextField: UITextField {
  
    var customDelegate : CustomButtonInteractionProtocol? = nil
    
    var onSearchClick : (()->())? = nil
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.font = UIFont.systemFont(ofSize: 16)
    }
    
    var prefixLabel : UILabel?
    var searchButton : UIButton?
    
    @objc open var isLTRLanguage: Bool = UIApplication.shared.userInterfaceLayoutDirection == .leftToRight {
        didSet {
            updateTextAligment()
        }
    }
    
    func addSearchButton() {
        if searchButton == nil {
            searchButton = UIButton(type: .custom)
            searchButton?.setImage(UIImage(named: "btn_search"), for: .normal)
            searchButton?.addTarget(self, action: #selector(onSearchButtonTapped), for: .touchUpInside)
            self.addSubview(searchButton!)
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        searchButton!.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: searchButton!,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .trailing,
                           multiplier: 1.0,
                           constant: -10).isActive = true
        
        NSLayoutConstraint(item: searchButton!,
                           attribute: .centerY,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .centerY,
                           multiplier: 1.0,
                           constant: 0).isActive = true
    }
    
    @objc func onSearchButtonTapped() {
        //onSearchClick?()
        customDelegate?.alternativeClick()
        searchButton?.provideAnimation()
        
    }
    
    func addPrefix(prefix : String) {
        if !prefix.isEmpty {
            if prefixLabel == nil {
                prefixLabel = UILabel()
                prefixLabel?.textAlignment = .left
                prefixLabel?.textColor = UIColor.black
                prefixLabel?.font = self.font
                prefixLabel?.layer.cornerRadius = 5
                
                self.addSubview(prefixLabel!)
            }
            prefixLabel!.text = prefix
            self.translatesAutoresizingMaskIntoConstraints = false
            prefixLabel!.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint(item: prefixLabel!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 5).isActive = true
            NSLayoutConstraint(item: prefixLabel!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: prefixLabel!, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        }
    }
    
    @IBInspectable
    var insetX: CGFloat = 15
    
    @IBInspectable
    var insetY: CGFloat = -8
    
    fileprivate func updateTextAligment() {
        if isLTRLanguage {
            textAlignment = .left
            titleLabel.textAlignment = .center
        } else {
            textAlignment = .right
            titleLabel.textAlignment = .center
        }
    }
    
    open override var inputView: UIView? {
        didSet {
            self.tintColor = UIColor.clear
        }
    }
    
    // MARK: Animation timing
    
    /// The value of the title appearing duration
    @objc dynamic open var titleFadeInDuration: TimeInterval = 0.2
    /// The value of the title disappearing duration
    @objc dynamic open var titleFadeOutDuration: TimeInterval = 0.3
    
    // MARK: Colors
    
    fileprivate var cachedTextColor: UIColor = UIColor.lightGray
    
    /// A UIColor value that determines the text color of the editable text
    @IBInspectable
    override dynamic open var textColor: UIColor?{
        set {
            cachedTextColor = UIColor.gray
            updateControl(false)
        }
        get {
            return cachedTextColor
        }
    }
    
    /// A UIColor value that determines text color of the placeholder label
    @IBInspectable dynamic open var placeholderColor: UIColor = UIColor.black {
        didSet {
            updatePlaceholder()
        }
    }
    
    @IBInspectable dynamic open var customPlaceholderColor: UIColor = UIColor.black {
        didSet {
            updatePlaceholder()
        }
    }
    
    @IBInspectable dynamic open var lineViewBackground: UIColor = UIColor.white {
        didSet {
            updateLineColor()
        }
    }
    
    /// A UIFont value that determines text color of the placeholder label
    @objc dynamic open var placeholderFont: UIFont? {
        didSet {
            updatePlaceholder()
        }
    }
    
    fileprivate func updatePlaceholder() {
        guard let placeholder = placeholder, let font = placeholderFont ?? font else {
            return
        }
        let color = isEnabled ? customPlaceholderColor : disabledColor
#if swift(>=4.2)
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font
            ]
        )
#elseif swift(>=4.0)
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: font
            ]
        )
#else
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSForegroundColorAttributeName: color, NSFontAttributeName: font]
        )
#endif
    }
    
    /// A UIFont value that determines the text font of the title label
    @objc dynamic open var titleFont: UIFont = .systemFont(ofSize: 13) {
        didSet {
            self.font = titleFont
            updateTitleLabel()
        }
    }
    
    /// A UIColor value that determines the text color of the title label when in the normal state
    @IBInspectable dynamic open var titleColor: UIColor = UIColor.gray {
        didSet {
            updateTitleColor()
        }
    }
    
    @IBInspectable dynamic open var customTitleColor: UIColor = UIColor.gray {
        didSet {
            updateTitleColor()
        }
    }
    
    /// A UIColor value that determines the color of the bottom line when in the normal state
    @IBInspectable dynamic open var lineColor: UIColor = UIColor.lightGray {
        didSet {
            lineColor = UIColor.lightGray
            updateLineView()
        }
    }
    
    /// A UIColor value that determines the color used for the title label and line when the error message is not `nil`
    @IBInspectable dynamic open var errorColor: UIColor = .red {
        didSet {
            updateColors()
        }
    }
    
    /// A UIColor value that determines the color used for the line when error message is not `nil`
    @IBInspectable dynamic open var lineErrorColor: UIColor? {
        didSet {
            updateColors()
        }
    }
    
    /// A UIColor value that determines the color used for the text when error message is not `nil`
    @IBInspectable dynamic open var textErrorColor: UIColor? {
        didSet {
            updateColors()
        }
    }
    
    /// A UIColor value that determines the color used for the title label when error message is not `nil`
    @IBInspectable dynamic open var titleErrorColor: UIColor? {
        didSet {
            updateColors()
        }
    }
    
    /// A UIColor value that determines the color used for the title label and line when text field is disabled
    @IBInspectable dynamic open var disabledColor: UIColor = UIColor(white: 0.88, alpha: 1.0) {
        didSet {
            updateControl()
            updatePlaceholder()
        }
    }
    
    /// A UIColor value that determines the text color of the title label when editing
    @IBInspectable dynamic open var selectedTitleColor: UIColor = UIColor.green {
        didSet {
            selectedTitleColor = self.customLineColor ?? UIColor.green
            selectedBorderColor = self.customLineColor ?? UIColor.green
            updateTitleColor()
        }
    }
    
    /// A UIColor value that determines the text color of the title label when editing
    @IBInspectable dynamic open var customBorderWidth: CGFloat = 1.0 {
        didSet {
            
        }
    }
    
    /// A UIColor value that determines the color of the line in a selected state
    @IBInspectable dynamic open var customLineColor: UIColor? = nil {
        didSet {
            selectedBorderColor = self.customLineColor ?? UIColor.green
            selectedTitleColor = self.customLineColor ?? UIColor.green
            updateLineView()
        }
    }
    
    /// A UIColor value that determines the color of the line in a selected state
    @IBInspectable dynamic open var selectedBorderColor: UIColor = UIColor.green {
        didSet {
            
        }
    }
    
    // MARK: Line height
    
    /// A CGFloat value that determines the height for the bottom line when the control is in the normal state
    @IBInspectable dynamic open var lineHeight: CGFloat = 0.5 {
        didSet {
            updateLineView()
            setNeedsDisplay()
        }
    }
    
    /// A CGFloat value that determines the height for the bottom line when the control is in a selected state
    @IBInspectable dynamic open var selectedLineHeight: CGFloat = 1.0 {
        didSet {
            updateLineView()
            setNeedsDisplay()
        }
    }
    
    // MARK: View components
    
    /// The internal `UIView` to display the line below the text input.
    open var lineView: UIView!
    
    /// The internal `UILabel` that displays the selected, deselected title or error message based on the current state.
    open var titleLabel: UILabel!
    
    // MARK: Properties
    
    /**
     The formatter used before displaying content in the title label.
     This can be the `title`, `selectedTitle` or the `errorMessage`.
     The default implementation converts the text to uppercase.
     */
    open var titleFormatter: ((String) -> String) = { (text: String) -> String in
        
        /*if #available(iOS 9.0, *) {
         return text.localizedUppercase
         } else {
         return text.uppercased()
         }*/
        return text
    }
    
    /**
     Identifies whether the text object should hide the text being entered.
     */
    override open var isSecureTextEntry: Bool {
        set {
            super.isSecureTextEntry = newValue
            //fixCaretPosition()
        }
        get {
            return super.isSecureTextEntry
        }
    }
    
    /// A String value for the error message to display.
    @IBInspectable
    open var errorMessage: String? {
        didSet {
            updateControl(true)
        }
    }
    
    /// The backing property for the highlighted property
    fileprivate var _highlighted: Bool = false
    
    /**
     A Boolean value that determines whether the receiver is highlighted.
     When changing this value, highlighting will be done with animation
     */
    override open var isHighlighted: Bool {
        get {
            return _highlighted
        }
        set {
            _highlighted = newValue
            updateTitleColor()
            updateLineView()
        }
    }
    
    /// A Boolean value that determines whether the textfield is being edited or is selected.
    open var editingOrSelected: Bool {
        return super.isEditing || isSelected
    }
    
    /// A Boolean value that determines whether the receiver has an error message.
    open var hasErrorMessage: Bool {
        return errorMessage != nil && errorMessage != ""
    }
    
    fileprivate var _renderingInInterfaceBuilder: Bool = false
    
    /// The text content of the textfield
    @IBInspectable
    override open var text: String? {
        didSet {
            updateControl(false)
        }
    }
    
    /**
     The String to display when the input field is empty.
     The placeholder can also appear in the title label when both `title` `selectedTitle` and are `nil`.
     */
    @IBInspectable
    override open var placeholder: String? {
        didSet {
            setNeedsDisplay()
            updatePlaceholder()
            updateTitleLabel()
        }
    }
    
    /// The String to display when the textfield is editing and the input is not empty.
    @IBInspectable open var selectedTitle: String? {
        didSet {
            updateControl()
        }
    }
    
    /// The String to display when the textfield is not editing and the input is not empty.
    @IBInspectable open var title: String? {
        didSet {
            updateControl()
        }
    }
    
    // Determines whether the field is selected. When selected, the title floats above the textbox.
    open override var isSelected: Bool {
        didSet {
            updateControl(true)
        }
    }
    
    // MARK: - Initializers
    
    /**
     Initializes the control
     - parameter frame the frame of the control
     */
    override public init(frame: CGRect) {
        super.init(frame: frame)
        init_SkyFloatingLabelTextField()
    }
    
    /**
     Intialzies the control by deserializing it
     - parameter coder the object to deserialize the control from
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        init_SkyFloatingLabelTextField()
    }
    
    fileprivate final func init_SkyFloatingLabelTextField() {
        borderStyle = .none
        createLineView()
        createTitleLabel()
        updateColors()
        addEditingChangedObserver()
        updateTextAligment()
        addSearchButton()
    }
    
    fileprivate func addEditingChangedObserver() {
        self.addTarget(self, action: #selector(MaterialBorderedTextField.editingChanged), for: .editingChanged)
    }
    
    /**
     Invoked when the editing state of the textfield changes. Override to respond to this change.
     */
    @objc open func editingChanged() {
        updateControl(true)
        updateTitleLabel(true)
    }
    
    // MARK: create components
    
    fileprivate func createTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        titleLabel.font = titleFont
        titleLabel.alpha = 0.0
        titleLabel.textColor = customTitleColor
        titleLabel.textAlignment = .center
        //titleLabel.backgroundColor = UIColor.white
        titleLabel.layer.cornerRadius = 8
        addSubview(titleLabel)
        self.titleLabel = titleLabel
    }
    
    fileprivate func createLineView() {
        
        if lineView == nil {
            let lineView = UIView()
            lineView.isUserInteractionEnabled = false
            self.lineView = lineView
            
            configureDefaultLineHeight()
        }
        
        lineView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        addSubview(lineView)
    }
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(selectAll(_:)) || action == #selector(paste(_:)) {
            return true
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
    fileprivate func configureDefaultLineHeight() {
        let onePixel: CGFloat = 1.0 / UIScreen.main.scale
        lineHeight = 2.0 * onePixel
        selectedLineHeight = 2.0 * self.lineHeight
    }
    
    // MARK: Responder handling
    
    /**
     Attempt the control to become the first responder
     - returns: True when successfull becoming the first responder
     */
    @discardableResult
    override open func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        updateControl(true)
        return result
    }
    
    /**
     Attempt the control to resign being the first responder
     - returns: True when successfull resigning being the first responder
     */
    @discardableResult
    override open func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        updateControl(true)
        return result
    }
    
    /// update colors when is enabled changed
    override open var isEnabled: Bool {
        didSet {
            updateControl()
            updatePlaceholder()
        }
    }
    
    // MARK: - View updates
    
    fileprivate func updateControl(_ animated: Bool = false) {
        updateColors()
        updateLineView()
        updateTitleLabel(animated)
    }
    
    fileprivate func updateLineView() {
        guard let lineView = lineView else {
            return
        }
        
        //lineView.frame = self.bounds //lineViewRectForBounds(bounds, editing: editingOrSelected)
        updateLineColor()
    }
    
    // MARK: - Color updates
    
    /// Update the colors for the control. Override to customize colors.
    open func updateColors() {
        updateLineColor()
        updateTitleColor()
        updateTextColor()
    }
    
    fileprivate func updateLineColor() {
        guard let lineView = lineView else {
            return
        }
        lineView.backgroundColor = lineViewBackground
        
        if !isEnabled {
            lineView.layer.borderColor = disabledColor.cgColor
        } else if hasErrorMessage {
            lineView.layer.borderColor = (lineErrorColor ?? errorColor).cgColor
        } else {
            lineView.layer.borderColor = (editingOrSelected ? selectedBorderColor : lineColor).cgColor
        }
    }
    
    var widthOfTitleText : CGFloat {
        let size: CGSize = titleLabel.text?.size(withAttributes: [NSAttributedString.Key.font: titleFont]) ?? CGSize.zero
        return size.width > 0 ? (size.width + 10) : 0
    }
    
    fileprivate func updateTitleColor() {
        guard let titleLabel = titleLabel else {
            return
        }
        
        if !isEnabled {
            titleLabel.textColor = disabledColor
        } else if hasErrorMessage {
            titleLabel.textColor = titleErrorColor ?? errorColor
        } else {
            if editingOrSelected || isHighlighted {
                titleLabel.textColor = selectedTitleColor
            } else {
                titleLabel.textColor = customTitleColor
            }
        }
    }
    
    fileprivate func updateTextColor() {
        if !isEnabled {
            super.textColor = disabledColor
        } else if hasErrorMessage {
            super.textColor = textErrorColor ?? errorColor
        } else {
            super.textColor = UIColor.gray
        }
    }
    
    // MARK: - Title handling
    
    fileprivate func updateTitleLabel(_ animated: Bool = false) {
        guard let titleLabel = titleLabel else {
            return
        }
        
        var titleText: String?
        if hasErrorMessage {
            titleText = titleFormatter(errorMessage!)
        } else {
            if editingOrSelected {
                titleText = selectedTitleOrTitlePlaceholder()
                if titleText == nil {
                    titleText = titleOrPlaceholder()
                }
            } else {
                titleText = titleOrPlaceholder()
            }
        }
        titleLabel.text = titleText
        titleLabel.font = titleFont
        
        updateTitleVisibility(animated)
        //titleLabel.sizeToFit()
    }
    
    fileprivate var _titleVisible: Bool = false
    
    /*
     *   Set this value to make the title visible
     */
    open func setTitleVisible(
        _ titleVisible: Bool,
        animated: Bool = false,
        animationCompletion: ((_ completed: Bool) -> Void)? = nil
    ) {
        if _titleVisible == titleVisible {
            return
        }
        _titleVisible = titleVisible
        updateTitleColor()
        updateTitleVisibility(animated, completion: animationCompletion)
    }
    
    open override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.clearButtonRect(forBounds: bounds)
        return rect.offsetBy(dx: 0, dy: 6)
    }
    
    /**
     Returns whether the title is being displayed on the control.
     - returns: True if the title is displayed on the control, false otherwise.
     */
    open func isTitleVisible() -> Bool {
        return hasText || hasErrorMessage || _titleVisible
    }
    
    fileprivate func updateTitleVisibility(_ animated: Bool = false, completion: ((_ completed: Bool) -> Void)? = nil) {
        let alpha: CGFloat = isTitleVisible() ? 1.0 : 0.0
        let frame: CGRect = titleLabelRectForBounds(bounds, editing: isTitleVisible())
        let updateBlock = { () -> Void in
            self.titleLabel.alpha = alpha
            self.titleLabel.frame = frame
        }
        if animated {
#if swift(>=4.2)
            let animationOptions: UIView.AnimationOptions = .curveEaseOut
#else
            let animationOptions: UIViewAnimationOptions = .curveEaseOut
#endif
            let duration = isTitleVisible() ? titleFadeInDuration : titleFadeOutDuration
            UIView.animate(withDuration: duration, delay: 0, options: animationOptions, animations: { () -> Void in
                updateBlock()
            }, completion: completion)
        } else {
            updateBlock()
            completion?(true)
        }
    }
    
    // MARK: - UITextField text/placeholder positioning overrides
    
    /**
     Calculate the rectangle for the textfield when it is not being edited
     - parameter bounds: The current bounds of the field
     - returns: The rectangle that the textfield should render in
     */
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.textRect(forBounds: bounds)
        let titleHeight = self.titleHeight()
        
        let rect = CGRect(
            x: superRect.origin.x + insetX,
            y: titleHeight + insetY,
            width: superRect.size.width - insetX,
            height: superRect.size.height - titleHeight - selectedLineHeight
        )
        return rect
    }
    
    /**
     Calculate the rectangle for the textfield when it is being edited
     - parameter bounds: The current bounds of the field
     - returns: The rectangle that the textfield should render in
     */
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.editingRect(forBounds: bounds)
        let titleHeight = self.titleHeight()
        
        let rect = CGRect(
            x: superRect.origin.x + insetX,
            y: titleHeight + insetY,
            width: superRect.size.width - 2*insetX,
            height: superRect.size.height - titleHeight - selectedLineHeight
        )
        return rect
    }
    
    /**
     Calculate the rectangle for the placeholder
     - parameter bounds: The current bounds of the placeholder
     - returns: The rectangle that the placeholder should render in
     */
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.textRect(forBounds: bounds)
        let rect = CGRect(
            x: superRect.origin.x + insetX,
            y: titleHeight() + insetY ,
            width: bounds.size.width,
            height: bounds.size.height - titleHeight() - selectedLineHeight
        )
        return rect
    }
    
    // MARK: - Positioning Overrides
    
    /**
     Calculate the bounds for the title label. Override to create a custom size title field.
     - parameter bounds: The current bounds of the title
     - parameter editing: True if the control is selected or highlighted
     - returns: The rectangle that the title label should render in
     */
    open func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        if editing {
            return CGRect(x: 5, y: -ceil(titleHeight()) / 2, width: ceil(widthOfTitleText), height: ceil(titleHeight()))
        }
        return CGRect(x: 5, y: titleHeight(), width: ceil(widthOfTitleText), height: ceil(titleHeight()))
    }
    
    /**
     Calculate the bounds for the bottom line of the control.
     Override to create a custom size bottom line in the textbox.
     - parameter bounds: The current bounds of the line
     - parameter editing: True if the control is selected or highlighted
     - returns: The rectangle that the line bar should render in
     */
    open func lineViewRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        return self.bounds
        //let height = editing ? selectedLineHeight : lineHeight
        //return CGRect(x: 0, y: bounds.size.height - height, width: bounds.size.width, height: height)
    }
    
    /**
     Calculate the height of the title label.
     -returns: the calculated height of the title label. Override to size the title with a different height
     */
    open func titleHeight() -> CGFloat {
        if let titleLabel = titleLabel,
           let font = titleLabel.font {
            return font.lineHeight
        }
        return 15.0
    }
    
    /**
     Calcualte the height of the textfield.
     -returns: the calculated height of the textfield. Override to size the textfield with a different height
     */
    open func textHeight() -> CGFloat {
        guard let font = self.font else {
            return 0.0
        }
        
        return font.lineHeight + 7.0
    }
    
    // MARK: - Layout
    
    /// Invoked when the interface builder renders the control
    override open func prepareForInterfaceBuilder() {
        if #available(iOS 8.0, *) {
            super.prepareForInterfaceBuilder()
        }
        
        borderStyle = .none
        
        isSelected = true
        _renderingInInterfaceBuilder = true
        updateControl(false)
        invalidateIntrinsicContentSize()
    }
    
    /// Invoked by layoutIfNeeded automatically
    override open func layoutSubviews() {
        super.layoutSubviews()
        let widthOfTitle = isTitleVisible() ? widthOfTitleText : 0
        
        let borderBound = CGRect.init(x: 0 , y: 0, width: bounds.width , height: bounds.height)
        titleLabel.layer.backgroundColor = UIColor.white.cgColor
        titleLabel.frame = titleLabelRectForBounds(bounds, editing: isTitleVisible() || _renderingInInterfaceBuilder)
        lineView.frame = borderBound
        lineView.layer.cornerRadius = 8
        lineView.layer.borderWidth = 1
        lineView.layer.borderColor = UIColor.lightGray.cgColor
        updateLineColor()
    }
    
    func getBorderWidth() -> CGFloat {
        return editingOrSelected ? customBorderWidth : 0.5
    }
    
    /**
     Calculate the content size for auto layout
     
     - returns: the content size to be used for auto layout
     */
    override open var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.size.width, height: titleHeight() + textHeight())
    }
    
    // MARK: - Helpers
    
    fileprivate func titleOrPlaceholder() -> String? {
        guard let title = title ?? placeholder else {
            return nil
        }
        return titleFormatter(title)
    }
    
    fileprivate func selectedTitleOrTitlePlaceholder() -> String? {
        guard let title = selectedTitle ?? title ?? placeholder else {
            return nil
        }
        return titleFormatter(title)
    }
} // swiftlint:disable:this file_length
