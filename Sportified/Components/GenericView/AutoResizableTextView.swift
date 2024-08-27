//
//  AutoResizableTextView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 03/05/2024.
//

import SwiftUI
struct AutoResizableTextView: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.text = text
        textView.font = UIFont(name: "Mulish-Bold", size: 13)
        textView.delegate = context.coordinator
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.textColorGray
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func textViewDidChange(_ textView: UITextView) {
            text = textView.text
        }
    }
}
