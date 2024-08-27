//
//  CricketScoreCardView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import SwiftUI

struct CricketScoreCardView: View {
    
    @State  var favoriteSportsList = ["","","","","",""]
    @State var favoriteSportsName = ["Cricket","Football","Badminton","Golf","Tennis","Basketball"]
    
    var body: some View {
        
        ScrollView(showsIndicators: false){
            
            VStack{
         
                
                VStack{
                    HStack{
                        
                        VStack(alignment:.leading){
                            Text("Team 1").font(Font.mulishMedium(size: 14)).foregroundColor(Color.textColorGray)
                            Text("15-0(3.0/10)").font(Font.mulishMedium(size: 14)).foregroundColor(Color.textColorGray)
                        }.padding(.leading,30)
                        Spacer()
                        VStack(alignment:.leading){
                            Text("CRR").font(Font.mulishMedium(size: 14)).foregroundColor(Color.textColorGray)
                            Text("5.00").font(Font.mulishMedium(size: 14)).foregroundColor(Color.textColorGray)
                        }
                        Spacer()
                    }.frame(height: 86).background(Color.textFieldColor).cornerRadius(15).padding(.top)
                    
                    HStack{
                        Spacer()
                        Text("P’SHIP  15(18)").font(Font.mulishMedium(size: 14)).foregroundColor(Color.textColorGray)
                        Spacer()
                        Text("Player1 10(12)").font(Font.mulishMedium(size: 14)).foregroundColor(Color.textColorGray)
                        Spacer()
                        Text("Player2 5(6)").font(Font.mulishMedium(size: 14)).foregroundColor(Color.textColorGray)
                        Spacer()
                    }.frame(height: 32).background(Color.textFieldColor).cornerRadius(10).padding(.top)
                    
                    HStack{
                        Spacer()
                        BallButton(title: "Wide")
                        Spacer()
                        BallButton(title: "No Ball")
                        Spacer()
                        BallButton(title: "Byes")
                        Spacer()
                        BallButton(title: "Leg Byes")
                        Spacer()
                    }.frame(height: 65).background(Color.textFieldColor).cornerRadius(15).padding(.top)
                    
                    HStack{
                        Spacer()
                        OverButton(ball: "1", overBall: true)
                        Spacer()
                        OverButton(ball: "2", overBall: true)
                        Spacer()
                        OverButton(ball: "3", overBall: true)
                        Spacer()
                        OverButton(ball: "")
                        Spacer()
                        OverButton(ball: "")
                        Spacer()
                        OverButton(ball: "")
                        Spacer()
                        
                    }.frame(height: 65).background(Color.textFieldColor).cornerRadius(15).padding(.top)
                    HStack{
                        Spacer()
                        Text(StringConstants.THISOVER).font(Font.mulishMedium(size: 14)).foregroundColor(Color.textColorGray)
                        Spacer()
                    }.frame(height: 32).background(Color.textFieldColor).cornerRadius(15).padding(.top)
                    
                    HStack(spacing: 25){
                        OverButtons(title: "RETIRE")
                       
                        OverButtons(title: "WICKET", showIcon: true)
                       
                        OverButtons(title: "OK")
                    }.padding(.top,15)
                    
                    HStack(spacing: 25){
                        OverButtons(title: "END INNINGS")
                       
                        OverButtons(title: "SWITCH BAT")
                       
                        OverButtons(title: "EDIT BAT")
                    }.padding(.top,15)
                    
                    HStack(){
                        CurrentOverView(buttonTitle: "Player1*",score: "10(12)")
                        Spacer()
                        CurrentOverView(buttonTitle: "Bowler1",image: "ic_cricket-ball",score: "10(12)")
                    }.padding(.top,15)
                    
                    AppButton(title: StringConstants.publish) {
                        
                    }.padding(.top,40)
                    
                    Spacer()
                    
                }.padding(.horizontal)
            }
        }
    }
}

#Preview {
    CricketScoreCardView()
}
struct BallButton: View {
    var title = ""
    var body: some View {
        HStack{
            CheckButton()
            Text(title).font(Font.mulishMedium(size: 14)).foregroundColor(Color.gray)
        }
    }
}

struct OverButton: View {
    var ball = ""
    var overBall = false
    
    var body: some View {
        HStack{
            Color(overBall ? .appGreen : .clear).frame(width: 14,height: 14)  .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.gray, lineWidth: overBall ? 0 : 1)).cornerRadius(40)
            Text(ball).font(Font.mulishMedium(size: 14)).foregroundColor(Color.gray)
            Image("ic_UpDown")
        }
    }
}
