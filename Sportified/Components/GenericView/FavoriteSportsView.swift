//
//  FavoriteSportsView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import SwiftUI

struct FavoriteSportsView: View {
    
    var favoriteSportsList:[SportsData]?
    var bgStroke = Color.gray
    var callBack:((Int)-> Void)?
    var body: some View {
        VStack(spacing: 0) {
            ForEach(favoriteSportsList?.indices ?? 0..<0, id: \.self) { row in
                HStack(spacing: 30) {
                    ForEach(0..<3) { col in
                        let itemIndex = row * 3 + col // Calculate the item index
                        if itemIndex < favoriteSportsList?.count ?? 0 {
                            var item = favoriteSportsList?[itemIndex]
                            Button {
                                callBack?(itemIndex)
                            } label: {
                                Text(favoriteSportsList?[itemIndex].name ?? "")
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 45)
                                    .foregroundColor(item?.isSelected ?? false ? Color.white : Color.gray)
                                    .background(item?.isSelected ?? false ? Color.appGreen : Color.clear)
                                    .cornerRadius(8)
                                    .font(.mulishRegular(size: 13.0))
                                    .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .stroke(bgStroke, lineWidth: item?.isSelected ?? false ? 0 : 0.5)).padding(.top,20)
                            }
                        }
                    }
                }
            }
        }.padding(.top,10)
    }
}

struct FavoriteSportsView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteSportsView(favoriteSportsList: [SportsData(name: "fas"),SportsData(name: "fas")])
    }
}

struct PreferencesViewButtons: View {
    
    var favoriteSportsList:[Sport]?
    var bgStroke = Color.gray
    var callBack:((Int)-> Void)?
    var body: some View {
        VStack(spacing: 0) {
            ForEach(favoriteSportsList?.indices ?? 0..<0, id: \.self) { row in
                HStack(spacing: 30) {
                    ForEach(0..<3) { col in
                        let itemIndex = row * 3 + col // Calculate the item index
                        if itemIndex < favoriteSportsList?.count ?? 0 {
                            let item = favoriteSportsList?[itemIndex]
                            
                            Text(favoriteSportsList?[itemIndex].name ?? "")
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                                .foregroundColor(item?.userFav ?? false ? Color.white : Color.gray)
                                .background(item?.userFav ?? false ? Color.appGreen : Color.clear)
                                .cornerRadius(8)
                                .font(.mulishRegular(size: 13.0))
                                .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .stroke(bgStroke, lineWidth: item?.userFav ?? false ? 0 : 0.5)).padding(.top,20)
                                .onTapGesture {
                                    callBack?(itemIndex)
                                }
                            
                        }
                    }
                }
            }
        }.padding(.top,10)
    }
}
