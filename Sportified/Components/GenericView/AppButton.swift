//
//  AppButton.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 01/05/2024.
//

import SwiftUI

enum ButtonType {
    case primary
    case primaryVarient
    case dropDown
}

struct AppButton: View {
    var title: String
    var height: CGFloat =  65
    var buttonType: ButtonType = .primary
    var foregroundColor: Color = Color.gray
    var backgroundColor: Color = Color.red
    var borderTextColor: Color = Color.gray
    var disableButton: Bool = false
    let callBack: (() -> Void)
    var body: some View {
        
        switch buttonType {
       
        case .primaryVarient:
            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    hideKeyboard()
                    callBack()
                }
            } label: {
                Text(title).frame(maxWidth: .infinity).frame(height: 55)
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    .cornerRadius(54)
                    .font(.mulishBold(size: 18.0))
                    .shadow(color: Color.green.opacity(0.38), radius: 14, x: 0, y: 8).padding(.top, 8)
            }
            
        case .dropDown:
            Button {
                callBack()
            } label: {
                HStack {
                    Text(title).foregroundColor(Color.textColorGray).font(Font.mulishMedium(size: 14))
                    Spacer()
                    
                    Button {
                        callBack()
                    } label: {
                        Image.ic_arrowDown.foregroundColor(Color.textColorGray).font(Font.mulishBold(size: 12))
                    }
                }.padding().frame(height: height).background(Color.textFieldColor).cornerRadius(10)
            }
            
        default:
            Button {
                callBack()
            } label: {
                ZStack {
                    Text(title)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .foregroundColor(Color.white)
                        .background(Color.appGreen)
                        .cornerRadius(54)
                        .font(.mulishSemiBold(size: 20.0))
                    
                    RoundedRectangle(cornerRadius: 54)
                        .stroke(Color.white.opacity(0.3), lineWidth: 3) // Adjust opacity as needed
                        .shadow(color: .white, radius: 10, x: 0, y: 0)
                        .clipShape(RoundedRectangle(cornerRadius: 54))
                        .padding(1) // Adjust padding to control the size of the shadow
                }.frame(height: 60)
            }
        }
    }
}

struct AppButton_Previews: PreviewProvider {
    static var previews: some View {
        AppButton(title: "Next", buttonType: .primary, callBack: {
            print("Button Pressed")
        })
    }
}

