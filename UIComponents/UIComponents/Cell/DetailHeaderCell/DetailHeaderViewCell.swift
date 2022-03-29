//
//  DetailHeaderViewCell.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 24.03.2022.
//

public class DetailHeaderViewCell: UICollectionViewCell, ReusableView {
    
    private let headerImageView = UIImageViewBuilder()
        .backgroundColor(.clear)
        .contentMode(.scaleAspectFill)
        .clipsToBounds(true)
        .build()
    
    private let editorsChoiceBadge = UIImageViewBuilder()
        .backgroundColor(.appWhite)
        .contentMode(.center)
        .image(.imgEditorsPick.resize(to: .init(width: 20, height: 24), for: .scaleAspectFit))
        .cornerRadius(20)
        .clipsToBounds(true)
        .build()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        configureContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubViews()
        configureContents()
    }
}

// MARK: - UILayout
extension DetailHeaderViewCell {
    
    private func addSubViews() {
        addHeaderImageView()
        addEditorsChoiceBadge()
    }
    
    private func addHeaderImageView() {
        contentView.addSubview(headerImageView)
        headerImageView.edgesToSuperview()
    }
    
    private func addEditorsChoiceBadge() {
        contentView.addSubview(editorsChoiceBadge)
        editorsChoiceBadge.top(to: headerImageView, offset: 15)
        editorsChoiceBadge.right(to: headerImageView, offset: -15)
    }
}

// MARK: - Configure
extension DetailHeaderViewCell {
    
    private func configureContents() {
        editorsChoiceBadge.size(.init(width: 40, height: 40))
    }
}

// MARK: - Set ViewModel
public extension DetailHeaderViewCell {
    
    func set(with viewModel: DetailHeaderViewCellProtocol, imageViews: [UIImageView], index: Int) {
        self.headerImageView.image = imageViews[index].image
        editorsChoiceBadge.isHidden = !viewModel.isEditorChoice
        let images: [UIImage] = imageViews.map({ $0.image ?? UIImage() })
        self.headerImageView.setupImageViewer(
            images: images,
            initialIndex: index,
            options: [.theme(.dark), .closeIcon(.icClose)])
    }
}
