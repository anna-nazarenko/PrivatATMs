//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.segue` struct is generated, and contains static references to 1 view controllers.
  struct segue {
    /// This struct is generated for `DevicesViewController`, and contains static references to 1 segues.
    struct devicesViewController {
      /// Segue identifier `goToDetails`.
      static let goToDetails: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, DevicesViewController, DetailsViewController> = Rswift.StoryboardSegueIdentifier(identifier: "goToDetails")

      #if os(iOS) || os(tvOS)
      /// Optionally returns a typed version of segue `goToDetails`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func goToDetails(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, DevicesViewController, DetailsViewController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.devicesViewController.goToDetails, segue: segue)
      }
      #endif

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 4 storyboards.
  struct storyboard {
    /// Storyboard `Details`.
    static let details = _R.storyboard.details()
    /// Storyboard `Exchange`.
    static let exchange = _R.storyboard.exchange()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Details", bundle: ...)`
    static func details(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.details)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Exchange", bundle: ...)`
    static func exchange(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.exchange)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 3 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")
    /// Color `currencyBackgroundColor`.
    static let currencyBackgroundColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "currencyBackgroundColor")
    /// Color `currencyIconColor`.
    static let currencyIconColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "currencyIconColor")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "currencyBackgroundColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func currencyBackgroundColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.currencyBackgroundColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "currencyIconColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func currencyIconColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.currencyIconColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "currencyBackgroundColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func currencyBackgroundColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.currencyBackgroundColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "currencyIconColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func currencyIconColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.currencyIconColor.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    struct uiApplicationSceneManifest {
      static let _key = "UIApplicationSceneManifest"
      static let uiApplicationSupportsMultipleScenes = false

      struct uiSceneConfigurations {
        static let _key = "UISceneConfigurations"

        struct uiWindowSceneSessionRoleApplication {
          struct defaultConfiguration {
            static let _key = "Default Configuration"
            static let uiSceneConfigurationName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneConfigurationName") ?? "Default Configuration"
            static let uiSceneDelegateClassName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate"
            static let uiSceneStoryboardFile = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneStoryboardFile") ?? "Main"

            fileprivate init() {}
          }

          fileprivate init() {}
        }

        fileprivate init() {}
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 1 nibs.
  struct nib {
    /// Nib `WorkingHoursCell`.
    static let workingHoursCell = _R.nib._WorkingHoursCell()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "WorkingHoursCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.workingHoursCell) instead")
    static func workingHoursCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.workingHoursCell)
    }
    #endif

    static func workingHoursCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> WorkingHoursCell? {
      return R.nib.workingHoursCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? WorkingHoursCell
    }

    fileprivate init() {}
  }

  /// This `R.reuseIdentifier` struct is generated, and contains static references to 2 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `ATMCell`.
    static let atmCell: Rswift.ReuseIdentifier<UIKit.UITableViewCell> = Rswift.ReuseIdentifier(identifier: "ATMCell")
    /// Reuse identifier `WorkingHoursCell`.
    static let workingHoursCell: Rswift.ReuseIdentifier<WorkingHoursCell> = Rswift.ReuseIdentifier(identifier: "WorkingHoursCell")

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 3 localization tables.
  struct string {
    /// This `R.string.exchange` struct is generated, and contains static references to 1 localization keys.
    struct exchange {
      /// uk translation: ???????? ??????????
      ///
      /// Locales: uk
      static let ysCzMJLTitle = Rswift.StringResource(key: "0ys-cz-mJL.title", tableName: "Exchange", bundle: R.hostingBundle, locales: ["uk"], comment: nil)

      /// uk translation: ???????? ??????????
      ///
      /// Locales: uk
      static func ysCzMJLTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("0ys-cz-mJL.title", tableName: "Exchange", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Exchange", preferredLanguages: preferredLanguages) else {
          return "0ys-cz-mJL.title"
        }

        return NSLocalizedString("0ys-cz-mJL.title", tableName: "Exchange", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    /// This `R.string.localizable` struct is generated, and contains static references to 18 localization keys.
    struct localizable {
      /// en translation: Bank
      ///
      /// Locales: en, uk
      static let exchangeView_bank = Rswift.StringResource(key: "ExchangeView_bank", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: Bitcoin
      ///
      /// Locales: en, uk
      static let currency_btc = Rswift.StringResource(key: "Currency_btc", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: Buy
      ///
      /// Locales: en, uk
      static let exchangeView_buy = Rswift.StringResource(key: "ExchangeView_buy", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: Euro
      ///
      /// Locales: en, uk
      static let currency_eur = Rswift.StringResource(key: "Currency_eur", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: Friday
      ///
      /// Locales: en, uk
      static let workingHours_friday = Rswift.StringResource(key: "WorkingHours_friday", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: Holiday
      ///
      /// Locales: en, uk
      static let workingHours_holiday = Rswift.StringResource(key: "WorkingHours_holiday", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: Monday
      ///
      /// Locales: en, uk
      static let workingHours_monday = Rswift.StringResource(key: "WorkingHours_monday", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: Privat24
      ///
      /// Locales: en, uk
      static let exchangeView_privat24 = Rswift.StringResource(key: "ExchangeView_privat24", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: Russian Ruble
      ///
      /// Locales: en, uk
      static let currency_rur = Rswift.StringResource(key: "Currency_rur", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: Sale
      ///
      /// Locales: en, uk
      static let exchangeView_sale = Rswift.StringResource(key: "ExchangeView_sale", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: Saturday
      ///
      /// Locales: en, uk
      static let workingHours_saturday = Rswift.StringResource(key: "WorkingHours_saturday", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: Sunday
      ///
      /// Locales: en, uk
      static let workingHours_sunday = Rswift.StringResource(key: "WorkingHours_sunday", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: Thursday
      ///
      /// Locales: en, uk
      static let workingHours_thursday = Rswift.StringResource(key: "WorkingHours_thursday", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: Tuesday
      ///
      /// Locales: en, uk
      static let workingHours_tuesday = Rswift.StringResource(key: "WorkingHours_tuesday", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: United State Dollar
      ///
      /// Locales: en, uk
      static let currency_usd = Rswift.StringResource(key: "Currency_usd", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: Unknowed
      ///
      /// Locales: en, uk
      static let currency_unknowed = Rswift.StringResource(key: "Currency_unknowed", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: Wednesday
      ///
      /// Locales: en, uk
      static let workingHours_wednesday = Rswift.StringResource(key: "WorkingHours_wednesday", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: Work schedule:
      ///
      /// Locales: en, uk
      static let detailsView_workSchedule = Rswift.StringResource(key: "DetailsView_workSchedule", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)

      /// en translation: Bank
      ///
      /// Locales: en, uk
      static func exchangeView_bank(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("ExchangeView_bank", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "ExchangeView_bank"
        }

        return NSLocalizedString("ExchangeView_bank", bundle: bundle, comment: "")
      }

      /// en translation: Bitcoin
      ///
      /// Locales: en, uk
      static func currency_btc(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Currency_btc", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Currency_btc"
        }

        return NSLocalizedString("Currency_btc", bundle: bundle, comment: "")
      }

      /// en translation: Buy
      ///
      /// Locales: en, uk
      static func exchangeView_buy(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("ExchangeView_buy", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "ExchangeView_buy"
        }

        return NSLocalizedString("ExchangeView_buy", bundle: bundle, comment: "")
      }

      /// en translation: Euro
      ///
      /// Locales: en, uk
      static func currency_eur(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Currency_eur", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Currency_eur"
        }

        return NSLocalizedString("Currency_eur", bundle: bundle, comment: "")
      }

      /// en translation: Friday
      ///
      /// Locales: en, uk
      static func workingHours_friday(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("WorkingHours_friday", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "WorkingHours_friday"
        }

        return NSLocalizedString("WorkingHours_friday", bundle: bundle, comment: "")
      }

      /// en translation: Holiday
      ///
      /// Locales: en, uk
      static func workingHours_holiday(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("WorkingHours_holiday", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "WorkingHours_holiday"
        }

        return NSLocalizedString("WorkingHours_holiday", bundle: bundle, comment: "")
      }

      /// en translation: Monday
      ///
      /// Locales: en, uk
      static func workingHours_monday(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("WorkingHours_monday", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "WorkingHours_monday"
        }

        return NSLocalizedString("WorkingHours_monday", bundle: bundle, comment: "")
      }

      /// en translation: Privat24
      ///
      /// Locales: en, uk
      static func exchangeView_privat24(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("ExchangeView_privat24", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "ExchangeView_privat24"
        }

        return NSLocalizedString("ExchangeView_privat24", bundle: bundle, comment: "")
      }

      /// en translation: Russian Ruble
      ///
      /// Locales: en, uk
      static func currency_rur(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Currency_rur", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Currency_rur"
        }

        return NSLocalizedString("Currency_rur", bundle: bundle, comment: "")
      }

      /// en translation: Sale
      ///
      /// Locales: en, uk
      static func exchangeView_sale(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("ExchangeView_sale", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "ExchangeView_sale"
        }

        return NSLocalizedString("ExchangeView_sale", bundle: bundle, comment: "")
      }

      /// en translation: Saturday
      ///
      /// Locales: en, uk
      static func workingHours_saturday(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("WorkingHours_saturday", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "WorkingHours_saturday"
        }

        return NSLocalizedString("WorkingHours_saturday", bundle: bundle, comment: "")
      }

      /// en translation: Sunday
      ///
      /// Locales: en, uk
      static func workingHours_sunday(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("WorkingHours_sunday", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "WorkingHours_sunday"
        }

        return NSLocalizedString("WorkingHours_sunday", bundle: bundle, comment: "")
      }

      /// en translation: Thursday
      ///
      /// Locales: en, uk
      static func workingHours_thursday(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("WorkingHours_thursday", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "WorkingHours_thursday"
        }

        return NSLocalizedString("WorkingHours_thursday", bundle: bundle, comment: "")
      }

      /// en translation: Tuesday
      ///
      /// Locales: en, uk
      static func workingHours_tuesday(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("WorkingHours_tuesday", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "WorkingHours_tuesday"
        }

        return NSLocalizedString("WorkingHours_tuesday", bundle: bundle, comment: "")
      }

      /// en translation: United State Dollar
      ///
      /// Locales: en, uk
      static func currency_usd(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Currency_usd", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Currency_usd"
        }

        return NSLocalizedString("Currency_usd", bundle: bundle, comment: "")
      }

      /// en translation: Unknowed
      ///
      /// Locales: en, uk
      static func currency_unknowed(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Currency_unknowed", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Currency_unknowed"
        }

        return NSLocalizedString("Currency_unknowed", bundle: bundle, comment: "")
      }

      /// en translation: Wednesday
      ///
      /// Locales: en, uk
      static func workingHours_wednesday(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("WorkingHours_wednesday", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "WorkingHours_wednesday"
        }

        return NSLocalizedString("WorkingHours_wednesday", bundle: bundle, comment: "")
      }

      /// en translation: Work schedule:
      ///
      /// Locales: en, uk
      static func detailsView_workSchedule(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("DetailsView_workSchedule", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "DetailsView_workSchedule"
        }

        return NSLocalizedString("DetailsView_workSchedule", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    /// This `R.string.main` struct is generated, and contains static references to 3 localization keys.
    struct main {
      /// uk translation: ???????? ??????????
      ///
      /// Locales: uk
      static let hd6FhUKVTitle = Rswift.StringResource(key: "Hd6-fh-uKV.title", tableName: "Main", bundle: R.hostingBundle, locales: ["uk"], comment: nil)
      /// uk translation: ??????????????????
      ///
      /// Locales: uk
      static let efpjrof2Title = Rswift.StringResource(key: "EFP-jR-oF2.title", tableName: "Main", bundle: R.hostingBundle, locales: ["uk"], comment: nil)
      /// uk translation: ??????????????????
      ///
      /// Locales: uk
      static let jytRmUsfTitle = Rswift.StringResource(key: "JYT-Rm-usf.title", tableName: "Main", bundle: R.hostingBundle, locales: ["uk"], comment: nil)

      /// uk translation: ???????? ??????????
      ///
      /// Locales: uk
      static func hd6FhUKVTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Hd6-fh-uKV.title", tableName: "Main", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Main", preferredLanguages: preferredLanguages) else {
          return "Hd6-fh-uKV.title"
        }

        return NSLocalizedString("Hd6-fh-uKV.title", tableName: "Main", bundle: bundle, comment: "")
      }

      /// uk translation: ??????????????????
      ///
      /// Locales: uk
      static func efpjrof2Title(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("EFP-jR-oF2.title", tableName: "Main", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Main", preferredLanguages: preferredLanguages) else {
          return "EFP-jR-oF2.title"
        }

        return NSLocalizedString("EFP-jR-oF2.title", tableName: "Main", bundle: bundle, comment: "")
      }

      /// uk translation: ??????????????????
      ///
      /// Locales: uk
      static func jytRmUsfTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("JYT-Rm-usf.title", tableName: "Main", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Main", preferredLanguages: preferredLanguages) else {
          return "JYT-Rm-usf.title"
        }

        return NSLocalizedString("JYT-Rm-usf.title", tableName: "Main", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib {
    struct _WorkingHoursCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = WorkingHoursCell

      let bundle = R.hostingBundle
      let identifier = "WorkingHoursCell"
      let name = "WorkingHoursCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> WorkingHoursCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? WorkingHoursCell
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try details.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try exchange.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try main.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct details: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = DetailsViewController

      let bundle = R.hostingBundle
      let detailsVC = StoryboardViewControllerResource<DetailsViewController>(identifier: "DetailsVC")
      let name = "Details"

      func detailsVC(_: Void = ()) -> DetailsViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: detailsVC)
      }

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.details().detailsVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'detailsVC' could not be loaded from storyboard 'Details' as 'DetailsViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct exchange: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = ExchangeViewController

      let bundle = R.hostingBundle
      let exchangeVC = StoryboardViewControllerResource<ExchangeViewController>(identifier: "ExchangeVC")
      let name = "Exchange"

      func exchangeVC(_: Void = ()) -> ExchangeViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: exchangeVC)
      }

      static func validate() throws {
        if #available(iOS 13.0, *) { if UIKit.UIImage(systemName: "banknote") == nil { throw Rswift.ValidationError(description: "[R.swift] System image named 'banknote' is used in storyboard 'Exchange', but couldn't be loaded.") } }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.exchange().exchangeVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'exchangeVC' could not be loaded from storyboard 'Exchange' as 'ExchangeViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 13.0, *) { if UIKit.UIImage(systemName: "creditcard.circle.fill") == nil { throw Rswift.ValidationError(description: "[R.swift] System image named 'creditcard.circle.fill' is used in storyboard 'LaunchScreen', but couldn't be loaded.") } }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = ViewController

      let bundle = R.hostingBundle
      let name = "Main"

      static func validate() throws {
        if #available(iOS 13.0, *) { if UIKit.UIImage(systemName: "creditcard") == nil { throw Rswift.ValidationError(description: "[R.swift] System image named 'creditcard' is used in storyboard 'Main', but couldn't be loaded.") } }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
