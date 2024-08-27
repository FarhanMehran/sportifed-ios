//
//  ResizableTextView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 22/05/2024.
//

import SwiftUI

struct ResizableTextView: UIViewRepresentable {
    
    @Binding var text: String
    @Binding var hight: CGFloat
    var placeholder: String = "Message"
    
    func makeCoordinator() -> Coordinator {
        return ResizableTextView.Coordinator(self)
    }
    
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = .clear
        textView.textColor = .gray
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.delegate = context.coordinator
        let placeholderLabel = UILabel()
        placeholderLabel.text = placeholder
        placeholderLabel.font = UIFont.systemFont(ofSize: 17)
        placeholderLabel.sizeToFit()
        placeholderLabel.textColor = .lightGray
        placeholderLabel.tag = 100 // A unique tag to identify the placeholder label
        placeholderLabel.isHidden = !text.isEmpty
        
        textView.addSubview(placeholderLabel)
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
        placeholderLabel.frame.origin = CGPoint(x: 8, y: textView.textContainerInset.top)
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
       if uiView.text != text {
            uiView.text = text
        }
        self.hight = uiView.contentSize.height
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: ResizableTextView
        
        init(_ parent: ResizableTextView) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.hight = textView.contentSize.height
            parent.text = textView.text
            // Show or hide the placeholder label
            if let placeholderLabel = textView.viewWithTag(100) as? UILabel {
                placeholderLabel.isHidden = !textView.text.isEmpty
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if self.parent.text == ""{
                textView.text = ""
            }
        }
    }
}
