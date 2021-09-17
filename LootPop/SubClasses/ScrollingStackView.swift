//
//  ScrollingStackView.swift
//  Eidolon
//
//  Created by Sako Hovaguimian on 8/10/21.
//

import UIKit

import UIKit

class ScrollingStackView: UIScrollView {
    
    private var stackView = UIStackView()
    private var axisConstraint: NSLayoutConstraint?
    
    //Set center Alignment for using contraints within arranged stackViews
    var alignment: UIStackView.Alignment {
        get { return self.stackView.alignment }
        set { self.stackView.alignment = newValue }
    }

    var axis: NSLayoutConstraint.Axis {
        get { return self.stackView.axis }
        set {
            updateStackViewAxis(
                newValue,
                edgeInsets: self.contentEdgeInsets
            )
        }
    }

    var isBaselineRelativeArrangement: Bool {
        get { return self.stackView.isBaselineRelativeArrangement }
        set { self.stackView.isBaselineRelativeArrangement = newValue }
    }

    var distribution: UIStackView.Distribution {
        get { return self.stackView.distribution }
        set { self.stackView.distribution = newValue }
    }

    var isLayoutMarginsRelativeArrangement: Bool {
        get { return self.stackView.isLayoutMarginsRelativeArrangement }
        set { self.stackView.isLayoutMarginsRelativeArrangement = newValue }
    }

    var spacing: CGFloat {
        get { return self.stackView.spacing }
        set { self.stackView.spacing = newValue }
    }
    
    var arrangedSubviews: [UIView] {
        return self.stackView.arrangedSubviews
    }
    
    override var layoutMargins: UIEdgeInsets {
        get { return self.stackView.layoutMargins }
        set { self.stackView.layoutMargins = newValue }
    }
    
    override  var directionalLayoutMargins: NSDirectionalEdgeInsets {
        get { return self.stackView.directionalLayoutMargins }
        set { self.stackView.directionalLayoutMargins = newValue }
    }

    var contentEdgeInsets: UIEdgeInsets = .zero {
        didSet {
            updateStackViewAxis(
                self.axis,
                edgeInsets: contentEdgeInsets
            )
        }
    }
    
    class var spacingUseDefault: CGFloat {
        return UIStackView.spacingUseDefault
    }

    class var spacingUseSystem: CGFloat {
        return UIStackView.spacingUseSystem
    }
    
    private var stackViewLeftConstraint: NSLayoutConstraint!
    private var stackViewRightConstraint: NSLayoutConstraint!
    private var stackViewTopConstraint: NSLayoutConstraint!
    private var stackViewBottomConstraint: NSLayoutConstraint!

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        setup(axis: .vertical)
        
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setup(axis: .vertical)
        
    }
    
    init(axis: NSLayoutConstraint.Axis = .vertical, arrangedSubviews: [UIView] = []) {
        
        super.init(frame: .zero)
        
        setup(axis: axis)
        
        for subview in arrangedSubviews {
            self.addArrangedSubview(subview)
        }
        
    }
    
    convenience init() {
        self.init(axis: .vertical)
    }
    
    private func setup(axis: NSLayoutConstraint.Axis) {
                
        self.clipsToBounds = true
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.stackView)
        
        self.stackViewLeftConstraint = self.stackView.leftAnchor.constraint(equalTo: self.leftAnchor)
        self.stackViewRightConstraint = self.stackView.rightAnchor.constraint(equalTo: self.rightAnchor)
        self.stackViewTopConstraint = self.stackView.topAnchor.constraint(equalTo: self.topAnchor)
        self.stackViewBottomConstraint = self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)

        NSLayoutConstraint.activate([
            self.stackViewLeftConstraint,
            self.stackViewRightConstraint,
            self.stackViewTopConstraint,
            self.stackViewBottomConstraint
        ])
        
        self.axis = axis
        
    }
    
    private func updateStackViewAxis(_ axis: NSLayoutConstraint.Axis, edgeInsets: UIEdgeInsets) {
        
        self.axisConstraint?.isActive = false
        
        switch axis {
        case .vertical:
            
            self.axisConstraint = self.stackView.widthAnchor.constraint(
                equalTo: self.widthAnchor,
                constant: -(edgeInsets.left + edgeInsets.right)
            )
            
        case .horizontal:
            
            self.axisConstraint = self.stackView.heightAnchor.constraint(
                equalTo: self.heightAnchor,
                constant: -(edgeInsets.top + edgeInsets.bottom)
            )
        
        default: break
        }
        
        self.stackViewLeftConstraint.constant = edgeInsets.left
        self.stackViewRightConstraint.constant = -edgeInsets.right
        self.stackViewTopConstraint.constant = edgeInsets.top
        self.stackViewBottomConstraint.constant = -edgeInsets.bottom
        
        self.axisConstraint?.isActive = true
        self.stackView.axis = axis

    }
    
    func addArrangedSubview(_ view: UIView) {
        self.stackView.addArrangedSubview(view)
    }

    func insertArrangedSubview(_ view: UIView, at stackIndex: Int) {
        self.stackView.insertArrangedSubview(view, at: stackIndex)
    }

    func removeArrangedSubview(_ view: UIView) {
        self.stackView.removeArrangedSubview(view)
    }
    
    func customSpacing(after arrangedSubview: UIView) -> CGFloat {
        return self.stackView.customSpacing(after: arrangedSubview)
    }

    func setCustomSpacing(_ spacing: CGFloat, after arrangedSubview: UIView) {
        self.stackView.setCustomSpacing(spacing, after: arrangedSubview)
    }
    
}
