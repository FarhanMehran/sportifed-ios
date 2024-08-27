//
//  NearbyGamesScecondListView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import SwiftUI
enum CommunitiesButtonType{
    case home
    case communities
}
struct NearbyGamesScecondListView: View {
    
    var buttonType: CommunitiesButtonType = .home
    var title:String = "Organize Game"
    var callBack: (()->Void)?
    var body: some View {
        ZStack{
            HStack{
                if buttonType == .communities{
                    Image.ic_Men.padding(.all,20).background(Color.textFieldColor).clipShape(Circle()).shadow(color: .white, radius: 0.5, x: 0, y: 0)
                        .padding(.leading,5)
                }
                VStack(alignment: .leading){
                  
                        
                        Text("This Feature is only for organizers")
                            .padding()
                            .frame(height: 25)
                            .foregroundColor(Color.textColorGray)
                            .background(Color.textFieldColor)
                            .cornerRadius(6)
                            .font(.mulishMedium(size: 12.0))
                    
                    HStack{
                        Text(title).font(Font.mulishBold(size: 18)).foregroundColor(.textColor)
                        
                        Spacer()
                        
                        if buttonType == .home{
                            Text("Create").frame(maxWidth: 100).frame(height: 35)
                                .foregroundColor(Color.textColor)
                                .cornerRadius(8)
                                .font(.mulishSemiBold(size: 16.0))
                                .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.appGrayColor, lineWidth:1))
                              
                        }
                    }
                    Text("Organize games and earn money").font(Font.mulishSemiBold(size: 12)).foregroundColor(Color.textColorGray)
                }.padding(.horizontal,buttonType == .communities ? 5 : 10).padding(.vertical)
            }
        }.frame(maxWidth: .infinity).background(Color.white)
            .onTapGesture {
                callBack?()
            }
            .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.appGrayColor, lineWidth: 1)
        )
    }
}

#Preview {
    NearbyGamesScecondListView()
}
