//
//  NearbyGamesListView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import SwiftUI

struct NearbyGamesListView: View {
    var model:NearbyMatchesList?
    var callBack:(()->Void)?
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading){
              
                HStack{
                    if model?.tournament != nil {
                        ListButton(title: StringConstants.tournament) {
                            
                        }
                    }
                    Spacer()
                    if model?.gameAccess == GameAccess.invite{
                        ListButton(title: StringConstants.inviteOnly,bgColor: Color.textFieldColor,foregroundColor: Color.textColorGray) {
                            
                        }
                    }
                }.padding(.top,10)
             
                HStack(spacing: 0){
                    
                    ZStack{
                        ForEach(0..<(model?.users?.count ?? 0), id: \.self){ index in
                            let image = model?.users?[index]
                            if index < 3{
                               
                                WebImageView(image: image?.img ?? "").frame(width: 40,height: 40).clipShape(.circle)
                                    .offset(x: index == 1 ? 20 : index == 2 ? 40 : 0)
                            }
                        }
                    }.frame(maxWidth: model?.users?.count == 1 ? 50 : model?.users?.count ?? 0 >= 2 ? 95
                            : 0,alignment: .leading)
                     
                    
                    HStack(spacing: 0){
                        Text("Players \(model?.users?.count ?? 0)/").font(Font.mulishMedium(size: 16)).foregroundColor(.textColor)
                        Text("\(model?.playersLimit ?? 0)" ).font(Font.mulishMedium(size: 16)).foregroundColor(Color.textColorGray)
                    }
                    
                    
                }.padding(.top,10)
                
                Text(model?.gameDateTime?.formattedDateTime ?? "").font(Font.mulishMedium(size: 16)).foregroundColor(.textColor).padding(.top,5)
                Text(model?.title ?? "").font(Font.mulishSemiBold(size: 20)).foregroundColor(.textColor).padding(.top,2)
                HStack{
                    Image.ic_Location
                    Text(model?.venue ?? "").font(Font.mulishMedium(size: 13)).foregroundColor(Color.textColorGray)
                }
            }.padding(.horizontal)
            CustomDivider().padding(.top,5)
            HStack{
                Text(StringConstants.entryFee).font(Font.mulishMedium(size: 16)).foregroundColor(.textColor)
                Spacer()
                Text(model?.fee ?? "").font(Font.mulishMedium(size: 16)).foregroundColor(.appGreen)
            }.padding(.vertical,12).padding(.horizontal).offset(y: -3)
            
        }.background(Color.white).overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.strokColor, lineWidth: 1)
        ).onTapGesture {
            callBack?()
        }
    }
}

#Preview {
    
    NearbyGamesListView()
}


