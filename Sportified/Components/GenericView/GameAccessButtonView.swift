//
//  GameAccessButtonView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 03/05/2024.
//

import SwiftUI

struct GameAccessButton: View {
    @Binding var gameAccess: GameAccess
    @Namespace private var animation
    var body: some View {
        HStack(spacing: 0) {
            HStack{
                if gameAccess != .invite{
                    Image.ic_World
                }else{
                    Image.ic_World_b
                }
               
                Text(StringConstants.publicKey).foregroundColor(gameAccess == .gameAccessPublic ? Color.white : Color.textColor).font(Font.mulishMedium(size: 18))
                
            }.frame(maxWidth: .infinity).frame( height: 50)
                .if(gameAccess == .gameAccessPublic) {
                    $0.background(Color.appGreen).matchedGeometryEffect(id: "referenceSegment", in: animation)
                }.onTapGesture {
                    withAnimation(.spring(response: 1.5, dampingFraction: 0.7)) {
                        gameAccess = .gameAccessPublic
                    }
                }.background(gameAccess != .invite ? Color.appGreen : Color.textFieldColor)
                .cornerRadius(13, corners: [.topLeft, .bottomLeft])
            
            HStack{
                if gameAccess == .gameAccessPublic{
                    Image.ic_Lock
                }else{
                    Image.ic_Lock_W
                }
                Text(StringConstants.inviteOnly).foregroundColor(gameAccess == .invite ? Color.white : Color.textColor)
            }.frame(maxWidth: .infinity).frame(height: 50)
                .if(gameAccess == .invite) {
                    $0.background(Color.appGreen).matchedGeometryEffect(id: "referenceSegment", in: animation)
                }.onTapGesture {
                    withAnimation(.spring(response: 1.5, dampingFraction: 0.7)) {
                        gameAccess = .invite
                    }
                }.background(gameAccess == .invite ? Color.appGreen : Color.textFieldColor)
                .cornerRadius(13, corners: [.topRight, .bottomRight])
        }
    }
}

#Preview {
    GameAccessButton(gameAccess: .constant(.invite))
}
