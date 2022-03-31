// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {

  public enum Comment {
    /// Takipçi
    public static let follower = L10n.tr("Localizable", "Comment.follower")
    /// Tarif
    public static let recipe = L10n.tr("Localizable", "Comment.recipe")
    /// %@ Tarif %@ Takipçi
    public static func recipeAndFollower(_ p1: Any, _ p2: Any) -> String {
      return L10n.tr("Localizable", "Comment.recipeAndFollower", String(describing: p1), String(describing: p2))
    }
  }

  public enum Detail {
    /// YORUM EKLE
    public static let addComment = L10n.tr("Localizable", "Detail.addComment")
    ///  Yorum
    public static let comment = L10n.tr("Localizable", "Detail.comment")
    /// Yorumlar
    public static let comments = L10n.tr("Localizable", "Detail.comments")
    /// Takipçi
    public static let follower = L10n.tr("Localizable", "Detail.follower")
    ///  Like
    public static let like = L10n.tr("Localizable", "Detail.like")
    /// Malzemeler
    public static let necessaries = L10n.tr("Localizable", "Detail.necessaries")
    /// YORUM YOK.
    public static let noComment = L10n.tr("Localizable", "Detail.noComment")
    /// Tarif
    public static let recipe = L10n.tr("Localizable", "Detail.recipe")
    /// Yapılışı
    public static let stages = L10n.tr("Localizable", "Detail.stages")
  }

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

  public enum Forgot {
    /// E-mail Adresi
    public static let email = L10n.tr("Localizable", "Forgot.email")
    /// E-mail alanı boş bırakılamaz.
    public static let emptyEmail = L10n.tr("Localizable", "Forgot.emptyEmail")
    /// Sıfırla
    public static let reset = L10n.tr("Localizable", "Forgot.reset")
    /// Success
    public static let success = L10n.tr("Localizable", "Forgot.success")
    /// Şifre Sıfırlama
    public static let title = L10n.tr("Localizable", "Forgot.title")
  }

  public enum General {
    /// Geri
    public static let back = L10n.tr("Localizable", "General.back")
    /// Yeniden Dene
    public static let retry = L10n.tr("Localizable", "General.retry")
  }

  public enum Home {
    /// EDİTÖR SEÇİMİ
    public static let editorChoice = L10n.tr("Localizable", "Home.editorChoice")
    /// SON EKLENENLER
    public static let lastAdded = L10n.tr("Localizable", "Home.lastAdded")
  }

  public enum PopUp {
    /// Vazgeç
    public static let cancel = L10n.tr("Localizable", "PopUp.cancel")
    /// Login
    public static let login = L10n.tr("Localizable", "PopUp.login")
    /// Giriş yapmanız gereklidir.
    public static let loginWarning = L10n.tr("Localizable", "PopUp.loginWarning")
  }

  public enum Recipe {
    /// %@ Tarif %@ Takipçi
    public static func recipeAndFollower(_ p1: Any, _ p2: Any) -> String {
      return L10n.tr("Localizable", "Recipe.recipeAndFollower", String(describing: p1), String(describing: p2))
    }
    /// %@ Yorum %@ Beğeni
    public static func recipeCommnetAndLike(_ p1: Any, _ p2: Any) -> String {
      return L10n.tr("Localizable", "Recipe.recipeCommnetAndLike", String(describing: p1), String(describing: p2))
    }
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
