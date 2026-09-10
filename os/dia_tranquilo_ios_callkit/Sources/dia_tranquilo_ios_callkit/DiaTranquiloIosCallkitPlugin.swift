import Flutter
import UIKit
import CallKit

public class DiaTranquiloIosCallkitPlugin: NSObject, FlutterPlugin {

    private static let channelName =
        "com.khrstian.diatranquilo.ios/callkit"

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: channelName,
            binaryMessenger: registrar.messenger()
        )

        let instance = DiaTranquiloIosCallkitPlugin()

        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(
        _ call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) {
        switch call.method {

        case "isCallDirectoryEnabled":
            checkCallDirectoryStatus(result: result)

        case "openCallDirectorySettings":
            openCallDirectorySettings(result: result)

        case "reloadCallDirectoryExtension":
            reloadCallDirectoryExtension(result: result)

        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func checkCallDirectoryStatus(
        result: @escaping FlutterResult
    ) {
        guard let extensionIdentifier = callDirectoryExtensionIdentifier else {
            result(
                FlutterError(
                    code: "EXTENSION_ID_NOT_CONFIGURED",
                    message: "Call Directory Extension identifier is not configured.",
                    details: nil
                )
            )
            return
        }

        CXCallDirectoryManager.sharedInstance
            .getEnabledStatusForExtension(
                withIdentifier: extensionIdentifier
            ) { status, error in

                DispatchQueue.main.async {
                    if let error = error {
                        result(
                            FlutterError(
                                code: "CALL_DIRECTORY_STATUS_ERROR",
                                message: error.localizedDescription,
                                details: nil
                            )
                        )
                        return
                    }

                    switch status {
                    case .enabled:
                        result("enabled")

                    case .disabled:
                        result("disabled")

                    case .unknown:
                        result("unknown")

                    @unknown default:
                        result("unknown")
                    }
                }
            }
    }

    private func openCallDirectorySettings(
        result: @escaping FlutterResult
    ) {
        if #available(iOS 13.4, *) {
            CXCallDirectoryManager.sharedInstance.openSettings { error in
                DispatchQueue.main.async {
                    if let error = error {
                        result(
                            FlutterError(
                                code: "OPEN_SETTINGS_ERROR",
                                message: error.localizedDescription,
                                details: nil
                            )
                        )
                    } else {
                        result(true)
                    }
                }
            }
        } else {
            result(
                FlutterError(
                    code: "IOS_VERSION_UNSUPPORTED",
                    message: "Opening Call Directory settings requires iOS 13.4 or newer.",
                    details: nil
                )
            )
        }
    }

    private func reloadCallDirectoryExtension(
        result: @escaping FlutterResult
    ) {
        guard let extensionIdentifier = callDirectoryExtensionIdentifier else {
            result(
                FlutterError(
                    code: "EXTENSION_ID_NOT_CONFIGURED",
                    message: "Call Directory Extension identifier is not configured.",
                    details: nil
                )
            )
            return
        }

        CXCallDirectoryManager.sharedInstance
            .reloadExtension(
                withIdentifier: extensionIdentifier
            ) { error in

                DispatchQueue.main.async {
                    if let error = error {
                        result(
                            FlutterError(
                                code: "CALL_DIRECTORY_RELOAD_ERROR",
                                message: error.localizedDescription,
                                details: nil
                            )
                        )
                    } else {
                        result(true)
                    }
                }
            }
    }

    private var callDirectoryExtensionIdentifier: String? {
        guard
            let bundleIdentifier = Bundle.main.bundleIdentifier,
            !bundleIdentifier.isEmpty
        else {
            return nil
        }

        return "\(bundleIdentifier).CallDirectoryExtension"
    }
}
