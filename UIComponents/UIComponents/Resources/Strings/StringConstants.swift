// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {

  public enum Favorites {
    /// TÜMÜNÜ GÖR
    public static let seeAll = L10n.tr("Localizable", "Favorites.seeAll")
  }

  public enum FavoritesRecipeCell {
    /// %@ Yorum %@ Beğeni
    public static func recipeInfo(_ p1: Any, _ p2: Any) -> String {
      return L10n.tr("Localizable", "FavoritesRecipeCell.recipeInfo", String(describing: p1), String(describing: p2))
    }
  }

  public enum Home {
    /// EDİTÖR SEÇİMİ
    public static let editorChoice = L10n.tr("Localizable", "Home.editorChoice")
    /// SON EKLENENLER
    public static let lastAdded = L10n.tr("Localizable", "Home.lastAdded")
  }

  public enum Toast {
    /// Lütfen ekranı yukarıdan aşağıya kaydırarak yenileyiniz.
    public static let recipeRequestError = L10n.tr("Localizable", "Toast.recipeRequestError")
  }

  public enum UserView {
    /// Follow
    public static let follow = L10n.tr("Localizable", "UserView.follow")
    /// Following
    public static let following = L10n.tr("Localizable", "UserView.following")
  }

  public enum WalkThrough {
    /// Fodamy is the best place to find your favorite recipes in all around the world.
    public static let descriptionText = L10n.tr("Localizable", "WalkThrough.descriptionText")
    /// Welcome to Fodamy Network!
    public static let firstTitle = L10n.tr("Localizable", "WalkThrough.firstTitle")
    /// Share recipes with others.
    public static let lastTitle = L10n.tr("Localizable", "WalkThrough.lastTitle")
    /// İlerle
    public static let next = L10n.tr("Localizable", "WalkThrough.next")
    /// Finding recipes were not that easy.
    public static let secondTitle = L10n.tr("Localizable", "WalkThrough.secondTitle")
    /// Başla!
    public static let start = L10n.tr("Localizable", "WalkThrough.start")
    /// Add new recipe.
    public static let thirdTitle = L10n.tr("Localizable", "WalkThrough.thirdTitle")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
