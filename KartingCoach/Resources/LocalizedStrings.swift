// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {

  enum Basic {
    /// ---
    static let noTime = L10n.tr("Localizable", "basic.no_time")
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
    /// New circuit
    static let title = L10n.tr("Localizable", "new_circuit.title")
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

