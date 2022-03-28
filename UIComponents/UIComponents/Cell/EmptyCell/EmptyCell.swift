//
//  EmptyCell.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 26.03.2022.
//

public class EmptyCell: UICollectionViewCell, ReusableView {
    
    weak var viewModel: EmptyCellProtocol?
    
    private let infoLabel = UILabelBuilder()
        .textAlignment(.center)
        .numberOfLines(0)
        .font(.font(.nunitoSemiBold, size: .xLarge))
        .textColor(.appRaven)
        .build()
    
    public var setInfoLabelText: String? {
        willSet {
            infoLabel.text = newValue
        }
    }
    
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
    
    func set(viewModel: EmptyCellProtocol) {
        self.viewModel = viewModel
    }
}

// MARK: - UILayout
extension EmptyCell {
    
    private func addSubViews() {
        contentView.addSubview(infoLabel)
        infoLabel.edgesToSuperview()
    }
}

// MARK: - Configure
extension EmptyCell {
    
    private func configureContents() {
        contentView.backgroundColor = .appWhite
        contentView.width(bounds.size.width)
    }
}
