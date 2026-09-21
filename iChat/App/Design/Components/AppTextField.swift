//
//  AppTextField.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 21/09/2026.
//

import SwiftUI
import UIKit

struct AppTextField<FocusValue: Hashable>: View {
    let title: String
    @Binding var text: String

    let isSecure: Bool
    let textContentType: UITextContentType?
    let submitLabel: SubmitLabel
    let focus: FocusState<FocusValue?>.Binding
    let focusValue: FocusValue
    let onSubmit: () -> Void

    init(
        _ title: String,
        text: Binding<String>,
        isSecure: Bool = false,
        textContentType: UITextContentType? = nil,
        submitLabel: SubmitLabel = .done,
        focus: FocusState<FocusValue?>.Binding,
        equals focusValue: FocusValue,
        onSubmit: @escaping () -> Void = {}
    ) {
        self.title = title
        self._text = text
        self.isSecure = isSecure
        self.textContentType = textContentType
        self.submitLabel = submitLabel
        self.focus = focus
        self.focusValue = focusValue
        self.onSubmit = onSubmit
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            if shouldFloatTitle {
                Text(title)
                    .font(.appCaption2)
                    .foregroundStyle(isFocused ? AppColor.primary : AppColor.textSecondary)
                    .transition(
                        .move(edge: .top)
                        .combined(with: .opacity)
                    )
            }

            input
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 7)
        .frame(minHeight: 58, alignment: .leading)
        .background(
            AppColor.surface,
            in: RoundedRectangle(cornerRadius: 8)
        )
        .contentShape(Rectangle())
        .onTapGesture {
            focus.wrappedValue = focusValue
        }
        .animation(
            .easeOut(duration: 0.18),
            value: shouldFloatTitle
        )
    }

    @ViewBuilder
    private var input: some View {
        Group {
            if isSecure {
                SecureField(
                    shouldFloatTitle ? "" : title,
                    text: $text
                )
            } else {
                TextField(
                    shouldFloatTitle ? "" : title,
                    text: $text
                )
            }
        }
        .font(.appBody)
        .textFieldStyle(.plain)
        .tint(AppColor.primary)
        .foregroundStyle(AppColor.textPrimary)
        .textContentType(textContentType)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
        .submitLabel(submitLabel)
        .focused(focus, equals: focusValue)
        .onSubmit(onSubmit)
        .accessibilityLabel(title)
    }

    private var shouldFloatTitle: Bool {
        focus.wrappedValue == focusValue || !text.isEmpty
    }

    private var isFocused: Bool {
        focus.wrappedValue == focusValue
    }
}
