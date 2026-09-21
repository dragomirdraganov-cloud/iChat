//
//  AppSearchable.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 21/09/2026.
//

//import SwiftUI
//
//struct AppSearchable<FocusValue: Hashable>: View {
//    @State private var searchText: String = ""
//    let focus: FocusState<FocusValue?>.Binding
//
//    var body: some View {
//        HStack(spacing: 10) {
//            Image(systemName: "magnifyingglass")
//                .foregroundStyle(AppColor.textSecondary)
//
//            TextField("Buscar", text: $searchText)
//                .font(.appBody)
//                .foregroundStyle(AppColor.textPrimary)
//                .tint(AppColor.primary)
//                .focused($focusedField, equals: .chatBrowser)
//
//            if !searchText.isEmpty {
//                Button {
//                    searchText = ""
//                } label: {
//                    Image(systemName: "xmark.circle.fill")
//                        .foregroundStyle(AppColor.textSecondary)
//                }
//            }
//        }
//        .padding(.horizontal, 12)
//        .frame(height: 44)
//        .background(
//            AppColor.surface,
//            in: RoundedRectangle(cornerRadius: 12)
//        )
//    }
//}
