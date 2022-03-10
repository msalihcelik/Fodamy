//
//  WalkThroughCell.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 9.03.2022.
//

public class WalkThroughCell: UICollectionViewCell, ReusableView {
    
    weak var viewModel: WalkThroughCellProtocol?
    
    private let imageView = UIImageViewBuilder()
        .build()
    private let bottomView = UIViewBuilder()
        .build()
    private let stackView = UIStackViewBuilder()
        .axis(.vertical)
        .spacing(10)
        .build()
    private let titleLabel = UILabelBuilder()
        .font(.font(.nunitoBold, size: .xxLarge))
        .textAlignment(.center)
        .textColor(.appCinder)
        .numberOfLines(2)
        .build()
    private let descriptionLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .xLarge))
        .textAlignment(.center)
        .textColor(.appRaven)
        .numberOfLines(2)
        .build()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubViews()
    }
    
    public func set(viewModel: WalkThroughCellProtocol) {
        self.viewModel = viewModel
        self.imageView.image = viewModel.image
        self.titleLabel.text = viewModel.titleText
        self.descriptionLabel.text = viewModel.descriptionText
    }
}

// MARK: - UILayout
extension WalkThroughCell {
    
    private func addSubViews() {
        addImageView()
        addBottomView()
        addStackView()
        addLabels()
    }
    
    private func addImageView() {
        contentView.addSubview(imageView)
        imageView.edgesToSuperview(excluding: [.top, .bottom], insets: .left(50) + .right(50))
        imageView.centerYToSuperview()
        imageView.topToSuperview(offset: 30, relation: .equalOrGreater)
        imageView.aspectRatio(1)
        imageView.setHugging(.defaultLow, for: .vertical)
    }
    
    private func addBottomView() {
        contentView.addSubview(bottomView)
        bottomView.edgesToSuperview(excluding: .top)
        bottomView.topToBottom(of: imageView)
    }
    
    private func addStackView() {
        bottomView.addSubview(stackView)
        stackView.edgesToSuperview(excluding: [.top, .bottom], insets: .left(50) + .right(50))
        stackView.centerYToSuperview()
    }
    
    private func addLabels() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
    }
}
