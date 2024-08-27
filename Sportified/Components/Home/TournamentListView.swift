//
//  TournamentListView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 22/05/2024.
//

import SwiftUI

struct TournamentListView: View {
    var list:[NearbyMatchesList]? = [NearbyMatchesList(id: 1, gameType: .regular)]
    var callBack:((NearbyMatchesList)->Void)?
    var crossCallBack:(()->Void)?
    var body: some View {
        ZStack{
            ScrollView(showsIndicators: false){
                HStack{
                    Spacer()
                    HStack{
                        Spacer()
                        
                        ZStack{
                            Text("X").font(Font.mulishBold(size: 15)).foregroundColor(Color.red)
                        }.frame(width: 30, height: 30).background(Color.textFieldColor)
                            .clipShape(.circle)
                            .onTapGesture {
                                crossCallBack?()
                            }
                    }.padding(.top).padding(.trailing)
                  
                }
                if let list = list{
                    ForEach(list.indices, id: \.self){ index in
                        let item = list[index]
                        NearbyGamesListView(model: item, callBack: {
                            callBack?(item)
                        }).padding()
                    }
                }
               
                
            }.background(Color.white).cornerRadius(15).shadow(color: .black.opacity(0.25), radius: 15, x: 0, y: 0).padding(.vertical,60).padding(.horizontal)
        }.background(Color.black.opacity(0.5)).edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    TournamentListView()
}
