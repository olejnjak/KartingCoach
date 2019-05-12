import UIKit

let appDelegateClass: AnyClass? = NSClassFromString("KartingCoachTests.TestAppDelegate") ?? AppDelegate.self

let args = UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(
    to: UnsafeMutablePointer<Int8>.self,
    capacity: Int(CommandLine.argc)
)

// swiftlint:disable force_unwrapping
UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appDelegateClass!))
