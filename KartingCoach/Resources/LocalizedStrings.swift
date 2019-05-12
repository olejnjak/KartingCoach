// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {

  enum Basic {
    /// Cancel
    static let cancel = L10n.tr("Localizable", "basic.cancel")
    /// ---
    static let noTime = L10n.tr("Localizable", "basic.no_time")
    /// OK
    static let ok = L10n.tr("Localizable", "basic.ok")
  }

  enum CircuitDetail {
    /// Average:
    static let averageTime = L10n.tr("Localizable", "circuit_detail.average_time")
    /// Best:
    static let bestTime = L10n.tr("Localizable", "circuit_detail.best_time")
  }

  enum CircuitList {
    /// Circuits
    static let title = L10n.tr("Localizable", "circuit_list.title")
  }

  enum NewCircuit {
    /// Circuit name
    static let placeholder = L10n.tr("Localizable", "new_circuit.placeholder")
    /// New circuit
    static let title = L10n.tr("Localizable", "new_circuit.title")

    enum Errors {

      enum EmptyName {
        /// Name cannot be empty
        static let title = L10n.tr("Localizable", "new_circuit.errors.empty_name.title")
      }

      enum Exists {
        /// Name already exists
        static let title = L10n.tr("Localizable", "new_circuit.errors.exists.title")
      }
    }
  }

  enum NewRace {
    /// Add new lap
    static let add = L10n.tr("Localizable", "new_race.add")
    /// Save
    static let save = L10n.tr("Localizable", "new_race.save")
    /// New race
    static let title = L10n.tr("Localizable", "new_race.title")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}

