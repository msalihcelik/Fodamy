//
//  FavoritesRecipeCell.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 17.03.2022.
//

public class FavoritesRecipeCell: UICollectionViewCell, ReusableView {
    
    weak var viewModel: FavoritesRecipeCellProtocol?
    
    private let imageView = UIImageViewBuilder()
        .contentMode(.scaleAspectFill)
        .build()
    private let recipeDetailView = UIViewBuilder()
        .backgroundColor(.appWhite)
        .build()
    private let recipeStackView = UIStackViewBuilder()
        .axis(.vertical)
        .build()
    private let recipeTitleLabel = UILabelBuilder()
        .font(.font(.nunitoBold, size: .small))
        .textColor(.appCinder)
        .build()
    private let recipeInfoLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .small))
        .textColor(.appRaven)
        .build()
    
    private let profileImageView = UIImageViewBuilder()
        .clipsToBounds(true)
        .masksToBounds(true)
        .contentMode(.scaleAspectFill)
        .cornerRadius(15)
        .borderColor(UIColor.appRed.cgColor)
        .borderWidth(2)
        .backgroundColor(.appWhite)
        .build()
    private let usernameLabel: PaddingLabel = {
        let paddingLabel = PaddingLabel(withInsets: 3, 2, 15, 5)
        paddingLabel.font = .font(.nunitoBold, size: .xSmall)
        paddingLabel.backgroundColor = .appRed
        paddingLabel.textColor = .appWhite
        paddingLabel.size(.init(width: 80, height: 20))
        paddingLabel.layer.cornerRadius = 10
        paddingLabel.clipsToBounds = true
        return paddingLabel
    }()
    
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
    
    public func set(with viewModel: FavoritesRecipeCellProtocol) {
        self.viewModel = viewModel
        self.profileImageView.setImageScaled(viewModel.profileImageURL)
        self.imageView.setImageScaled(viewModel.recipeImageURL)
        self.recipeTitleLabel.text = viewModel.recipeTitle
        self.recipeInfoLabel.text = viewModel.recipeInfo
        self.usernameLabel.text = viewModel.username
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        recipeTitleLabel.text = nil
        recipeInfoLabel.text = nil
        profileImageView.image = nil
        usernameLabel.text = nil
    }
}

// MARK: - UILayout
extension FavoritesRecipeCell {
    
    private func addSubViews() {
        addImageView()
        addUsernameLabel()
        addProfileImageView()
        addRecipeDetailView()
        addRecipeStackView()
    }
    
    private func addImageView() {
        contentView.addSubview(imageView)
        imageView.edgesToSuperview(excluding: .bottom)
        imageView.aspectRatio(1)
    }
    
    private func addUsernameLabel() {
        contentView.addSubview(usernameLabel)
        usernameLabel.topToSuperview().constant = 10
        usernameLabel.leftToSuperview().constant = 20
    }
    
    private func addProfileImageView() {
        contentView.addSubview(profileImageView)
        profileImageView.width(30)
        profileImageView.aspectRatio(1)
        profileImageView.centerX(to: usernameLabel, usernameLabel.leftAnchor)
        profileImageView.centerY(to: usernameLabel, usernameLabel.centerYAnchor)
    }
    
    private func addRecipeDetailView() {
        contentView.addSubview(recipeDetailView)
        recipeDetailView.edgesToSuperview(excluding: .top)
        recipeDetailView.topToBottom(of: imageView)
    }
    
    private func addRecipeStackView() {
        recipeDetailView.addSubview(recipeStackView)
        recipeStackView.centerYToSuperview()
        recipeStackView.leadingToSuperview().constant = 10
        recipeStackView.trailingToSuperview()
        
        recipeStackView.addArrangedSubview(recipeTitleLabel)
        recipeStackView.addArrangedSubview(recipeInfoLabel)
    }
}

// MARK: - Configure & SetLocalize
extension FavoritesRecipeCell {
    
    private func configureContents() {
        configureCellShadow()
    }
    
    private func configureCellShadow() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 4
        
        layer.shadowColor = UIColor.appCinder.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 4.0
    }
}
