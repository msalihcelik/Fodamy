//
//  ToastPresenter.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 14.03.2022.
//

import SwiftEntryKit

public class ToastPresenter {
    
    public static func showWarningToast(text: String) {
        var attributes = EKAttributes.topToast
        attributes.entryBackground = .color(color: EKColor(light: .appRed, dark: .appRed))
        attributes.entranceAnimation = .translation
        attributes.exitAnimation = .translation

        let customView = TostWarningView(text: text)
        SwiftEntryKit.display(entry: customView, using: attributes)
    }
    
    public static func showSuccessToast(text: String) {
        var attributes = EKAttributes.topToast
        attributes.entryBackground = .color(color: EKColor(light: .appGreen, dark: .appGreen))
        attributes.entranceAnimation = .translation
        attributes.exitAnimation = .translation
        attributes.border = .value(color: .appBlack, width: 1)

        let customView = TostWarningView(text: text)
        SwiftEntryKit.display(entry: customView, using: attributes)
    }
}
