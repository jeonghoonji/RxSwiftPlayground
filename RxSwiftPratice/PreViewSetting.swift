//
//  PreViewSetting.swift
//  RxSwiftPratice
//
//  Created by 지정훈 on 7/2/24.
//

import Foundation

enum DeviceType {
    case iPhoneSE // iPhone SE (3rd generation)
    case iPhoneXS   // iPhone Xs
    case iPhone11   // iPhone 11
    case iPhone13Mini   // iPhone 13 mini
    case iPhone15Pro     // iPhone 15 Pro
    
    func name() -> String {
        switch self {
        case .iPhoneSE:
            return "iPhone SE (3rd generation)"
        case .iPhoneXS:
            return "iPhone Xs"
        case .iPhone11:
            return "iPhone 11"
        case .iPhone13Mini:
            return "iPhone 13 mini"
        case .iPhone15Pro:
            return "iPhone 15 Pro"
        }
    }
}

// MARK: - Preview 세팅

#if canImport(SwiftUI) && DEBUG
import SwiftUI
extension UIViewController {

    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }

    func showPreview(_ deviceType: DeviceType = .iPhone15Pro) -> some View {
        Preview(viewController: self)
            .previewDevice(PreviewDevice(rawValue: deviceType.name()))
    }
}
#endif
