//
//  HomeSecondaryAppBBar.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 03/05/2024.
//

import SwiftUI

struct HomeSecondaryAppBBar: View {
    var coordinator: HomeCoordinator?
    var title = "title"
    var showChatBar = false
    var showShareButton = false
    var showEditMatchButton = false
    var showUndoButton = false
    var btnBackCallBack: (()->Void)?
    var btnEditMatchCallBack: (()->Void)?
    var btnShareCallBack: (()->Void)?
    
    var body: some View {
        
        ZStack{
            HStack{
              
                Image.ic_ArrowBack.onTapGesture {
                    coordinator?.popNavigationView()
                    btnBackCallBack?()
                }.padding(.leading,15)
                if showChatBar{
                    Image.ic_Men.padding(.all,20).background(Color.textFieldColor).clipShape(Circle()).shadow(color: .white, radius: 0.5, x: 0, y: 0)
                        .padding(.horizontal,5)
                    Text(title).font(Font.mulishSemiBold(size: 20)).foregroundColor(.textColor)
                }
                Spacer()
                
                if showEditMatchButton {
                    Image("ic_Edit 1").onTapGesture {
                        btnEditMatchCallBack?()
                    }.padding(.trailing,15)
                }
                
                if showShareButton {
                    Image.ic_Share.onTapGesture {
                        btnShareCallBack?()
                    }.padding(.trailing,15)
                }
              
                
                if showUndoButton {
                    Text(StringConstants.UNDO).font(Font.mulishMedium(size: 15)).foregroundColor(Color.appGreen).padding(.trailing,20)
                        .onTapGesture {
                          //  btnUndoCallBack?()
                        }
                }
            }
            if !showChatBar{
                Text(title).font(Font.mulishSemiBold(size: 20)).foregroundColor(.textColor)
            }
        }
        CustomDivider()
    }
}

#Preview {
    HomeSecondaryAppBBar()
}
