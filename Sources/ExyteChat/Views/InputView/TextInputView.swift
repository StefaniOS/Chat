//
//  Created by Alex.M on 14.06.2022.
//

import SwiftUI

struct TextInputView: View {
    
    @Environment(\.chatTheme) private var theme
    
    @EnvironmentObject private var globalFocusState: GlobalFocusState
    
    @Binding var text: String
    @State var inputFieldId: UUID
    var style: InputViewStyle
    var availableInputs: [AvailableInputType]
    var localization: ChatLocalization
    
    var body: some View {
        TextField("", text: $text, axis: .vertical)
            .customFocus($globalFocusState.focus, equals: .uuid(inputFieldId))
            .placeholder(when: text.isEmpty) {
                Text(style == .message ? localization.inputPlaceholder : localization.signatureText)
                    .foregroundColor(style == .message ? theme.colors.inputPlaceholderText : theme.colors.inputSignaturePlaceholderText)
            }
            .foregroundColor(style == .message ? theme.colors.inputText : theme.colors.inputSignatureText)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .simultaneousGesture(
                TapGesture().onEnded {
                    globalFocusState.focus = .uuid(inputFieldId)
                }
            )
    }
}
