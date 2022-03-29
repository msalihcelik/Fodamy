//
//  CommentCell.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 25.03.2022.
//

public class CommentCell: UICollectionViewCell, ReusableView {

    private let userView = UserView(userViewType: .withoutFollowButton)
    
    private let timeLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .xSmall))
        .textColor(.appRaven)
        .build()
    
    private let commentLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .medium))
        .textColor(.appCinder)
        .numberOfLines(0)
        .build()
    
    private let ownerButton = UIButtonBuilder()
        .backgroundColor(.clear)
        .image(UIImage.icMore.withRenderingMode(.alwaysTemplate))
        .tintColor(.appCinder)
        .build()
    
    public var ownerButtonHidden: Bool? {
        get {
            return ownerButton.isHidden
        }
        set(newValue) {
            ownerButton.isHidden = newValue ?? false
        }
    }
    
    private lazy var width: NSLayoutConstraint = {
            let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
            width.isActive = true
            return width
        }()
    
    weak var viewModel: CommentCellProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubViews()
        configureContents()
    }
    
    public override func systemLayoutSizeFitting(_ targetSize: CGSize,
                                                     withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
                                                     verticalFittingPriority: UILayoutPriority) -> CGSize {
            width.constant = bounds.size.width
            return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
        }
    
    public func set(with viewModel: CommentCellProtocol) {
        self.viewModel = viewModel
        self.userView.userImageUrl = viewModel.imageUrl
        self.userView.username = viewModel.username
        self.userView.recipeAndFollowerCountText = viewModel.recipeAndFollower
        self.timeLabel.text = viewModel.time
        self.commentLabel.text = viewModel.commentText
        self.ownerButton.isHidden = !viewModel.isOwner
        self.viewModel?.commentChanged = { [weak self] in
            self?.commentLabel.text = self?.viewModel?.commentText
        }
    }
}

// MARK: - UILayout
extension CommentCell {
    
    private func addSubViews() {
        contentView.addSubview(userView)
        userView.edgesToSuperview(excluding: [.bottom, .right])
        
        contentView.addSubview(timeLabel)
        timeLabel.topToBottom(of: userView)
        timeLabel.leftToSuperview(offset: 15)
        timeLabel.rightToSuperview(offset: -15)
        
        contentView.addSubview(commentLabel)
        commentLabel.edgesToSuperview(excluding: .top, insets: .init(top: 0, left: 15, bottom: 4, right: 15))
        commentLabel.topToBottom(of: timeLabel, offset: 7)
        
        contentView.addSubview(ownerButton)
        ownerButton.edgesToSuperview(excluding: [.left, .bottom], insets: .top(10) + .right(15))
        ownerButton.leftToRight(of: userView)
    }
}

// MARK: - Configure
extension CommentCell {
    
    private func configureContents() {
        backgroundColor = .white
        userView.height(70)
        ownerButton.size(.init(width: 18, height: 4))
        ownerButton.addTarget(self, action: #selector(ownerButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions
extension CommentCell {
    
    @objc
    private func ownerButtonTapped() {
        viewModel?.ownerButtonTapped?()
    }
}
