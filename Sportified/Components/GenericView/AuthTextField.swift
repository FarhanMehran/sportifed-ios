//
//  AuthTextField.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 01/05/2024.
//

import Foundation
import SwiftUI
public enum TextFieldType {
    case normalField
    case secureField
    case searchField
   
}

struct AuthTextField: View {
    var title: String
    var type: TextFieldType = .normalField
    var keyboardType: UIKeyboardType = .default
    var isPassword: Bool = false
    @Binding var text: String
    var showPasswordCallback: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            switch type {
            case .secureField:
                
                HStack {
                    SecureField(title, text: $text).foregroundColor(Color.textColorGray).font(Font.mulishMedium(size: 14)).keyboardType(keyboardType)
                    
                    Spacer()
                    
                    Button {
                        showPasswordCallback?()
                    } label: {
                        Image(systemName: "eye.slash").foregroundColor(Color.textColorGray).font(Font.mulishBold(size: 12))
                    }
                }.padding().frame(height: 65).background(Color.textFieldColor).cornerRadius(10)
            case .searchField:
                HStack {
                    TextField(title, text:
                                $text).foregroundColor(Color.textColorGray).font(Font.mulishMedium(size: 14)).keyboardType(keyboardType)
                    
                
                        Spacer()
                        
                        Button {
                           
                        } label: {
                            Image.ic_Search.foregroundColor(Color.textColorGray).font(Font.mulishBold(size: 12))
                        }
                    
                }.padding().frame(height: 50).background(Color.textFieldColor).cornerRadius(15)
            default:
                HStack {
                    TextField(title, text: $text).foregroundColor(Color.textColorGray).font(Font.mulishMedium(size: 14)).keyboardType(keyboardType)
                        .autocapitalization(.none)
                    if isPassword {
                        Spacer()
                        
                        Button {
                            showPasswordCallback?()
                        } label: {
                            Image(systemName: "eye").foregroundColor(Color.textColorGray).font(Font.mulishBold(size: 12))
                        }
                    }
                }.padding().frame(height: 65).background(Color.textFieldColor).cornerRadius(10)
                
            }
        }
    }
}

struct AuthTextField_Previews: PreviewProvider {
    @State static var text = ""
    @State static var errorText = ""
    static var previews: some View {
        AuthTextField(title: "StringConstants.email", text: $text)
    }
}
