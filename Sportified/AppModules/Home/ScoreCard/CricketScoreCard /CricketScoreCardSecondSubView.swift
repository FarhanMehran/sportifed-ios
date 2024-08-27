//
//  dScoreCardSecondSubView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 29/05/2024.
//

import SwiftUI

struct CricketScoreCardSecondSubView: View {
    var model: CricketScoreCardSummary?
    var body: some View {
        VStack{
            
            VStack{
                
                HStack{
                    VStack(alignment: .leading){
                        Text(model?.data?.inning1?.team1Name ?? "Team a").font(Font.mulishMedium(size: 14)).foregroundColor(Color.textColorGray)
                        Text(model?.data?.inning2?.team2Name ?? "Team b").font(Font.mulishMedium(size: 14)).foregroundColor(Color.textColorGray).padding(.top,3)
                    }
                    Spacer()
                    VStack{
                        Text("\(model?.data?.inning1?.team1Score ?? 0)/\(model?.data?.inning1?.team1Wickets ?? 0) \(model?.data?.inning1?.totalOvers ?? "0.0")").font(Font.mulishMedium(size: 14)).foregroundColor(Color.textColorGray)
                        Text("\(model?.data?.inning2?.team2Score ?? 0)/\(model?.data?.inning2?.team2Wickets ?? 0) \(model?.data?.inning2?.totalOvers ?? "0.0")").font(Font.mulishMedium(size: 14)).foregroundColor(Color.textColorGray).padding(.top,3)
                    }
                    
                }
                HStack{
                    //Team 0 won by 0 runs
                    Text(" ").font(Font.mulishRegular(size: 14)).foregroundColor(Color.appGreenColor).padding(.top,5)
                Spacer()
                }
            }.padding(.horizontal).frame(height: 135).background(Color.textFieldColor).cornerRadius(15)
            
            VStack{
                ZStack{
                    Image.ic_Arrw
                    HStack{
                        
                        Text(model?.data?.inning1?.team1Name ?? "Team A").font(Font.mulishMedium(size: 14)).foregroundColor(Color.textColorGray)
                        
                        Spacer()
                        
                        Text("\(model?.data?.inning1?.team1Score ?? 0)-\(model?.data?.inning1?.team1Wickets ?? 0)").font(Font.mulishMedium(size: 15)).foregroundColor(Color.textColorGray)
                        Text("(\(model?.data?.inning1?.totalOvers ?? "0.0")/\(model?.data?.totalOvers ?? 0))").font(Font.mulishMedium(size: 12)).foregroundColor(Color.textColorGray)
                    }
                    
                }.padding(.horizontal).frame(height: 65).background(Color.textFieldColor).cornerRadius(15)
                
                RuniningView(changeColor: true, height: 32).padding(.top)
                ForEach(0..<(model?.data?.inning1?.players?.count ?? 0), id: \.self){ index in
                    let player = model?.data?.inning1?.players?[index]
                    RuniningView(isShowLine: true,playerName: player?.name ?? "bastsman",
                                 r: "\(player?.runsScored ?? 0)",
                                 b: "\(player?.ballsFaced ?? 0)",
                                 s4: "\(player?.fours ?? 0)",
                                 s6: "\(player?.sixes ?? 0)",
                                 sr: "\(player?.strikeRate ?? 0)")
                }
                
                ZStack{
                    if let extras = model?.data?.inning1?.extras {
                        let totalExtras = (extras.byes ?? 0) +
                        (extras.noBalls ?? 0) +
                        (extras.wides ?? 0) +
                        (extras.legByes ?? 0)
                        
                        Text("Extras \(totalExtras) (b \(extras.byes ?? 0),w \(extras.wides ?? 0),nb \(extras.noBalls ?? 0),lb \(extras.legByes ?? 0))").font(Font.mulishMedium(size: 13)).foregroundColor(Color.textColorGray)
                    }else{
                        Text("Extras 0 (b 0,w 0,nb 0,lb 0)").font(Font.mulishMedium(size: 13)).foregroundColor(Color.textColorGray)
                    }
                }.frame(maxWidth: .infinity).frame(height: 32).background(Color.textFieldColor).cornerRadius(10).padding(.top)
                
                HStack(spacing:0){
                    Text(StringConstants.total).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColorGray)
                    Spacer()
                    Text("\(model?.data?.inning1?.team1Score ?? 0)/\(model?.data?.inning1?.team1Wickets ?? 0) ").font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColorGray)
                    Text("(\(model?.data?.inning1?.totalOvers ?? "0.0"))").font(Font.mulishMedium(size: 13)).foregroundColor(Color.textColorGray)
                }.padding(.horizontal).frame(maxWidth: .infinity).frame(height: 58).background(Color.textFieldColor).cornerRadius(14).padding(.top)
                VStack{
                    RuniningView(changeColor: true, height: 32,
                                 playerName: "Bowlers",
                                 r: "O",
                                 b: "D",
                                 s4: "R ",
                                 s6: "W ",
                                 sr: "ER").padding(.top)
                    ForEach(0..<(model?.data?.inning1?.bowlers?.count ?? 0), id: \.self){ i in
                        let player = model?.data?.inning1?.bowlers?[i]
                        RuniningView(isShowLine: true,
                                     playerName: player?.name ?? "bowlers",
                                     r: "\(player?.overs ?? "0")",
                                     b: "\(player?.dotBalls ?? 0)",
                                     s4: "\(player?.runsConceded ?? 0)",
                                     s6: "\(player?.wicketsTaken ?? 0)",
                                     sr: "\(player?.economyRate ?? 0)")
                        
                    }
                }
            }
            
            VStack{
                ZStack{
                    Image.ic_Arrw
                    HStack{
                        
                        Text(model?.data?.inning2?.team2Name ?? "Team B").font(Font.mulishMedium(size: 14)).foregroundColor(Color.textColorGray)
                        
                        Spacer()
                        
                        Text("\(model?.data?.inning2?.team2Score ?? 0)-\(model?.data?.inning2?.team2Wickets ?? 0)").font(Font.mulishMedium(size: 15)).foregroundColor(Color.textColorGray)
                        Text("(\(model?.data?.inning2?.totalOvers ?? "0.0")/\(model?.data?.totalOvers ?? 0))").font(Font.mulishMedium(size: 12)).foregroundColor(Color.textColorGray)
                    }
                    
                }.padding(.horizontal).frame(height: 65).background(Color.textFieldColor).cornerRadius(15).padding(.top)
                
                RuniningView(changeColor: true, height: 32).padding(.top)
                ForEach(0..<(model?.data?.inning2?.players?.count ?? 0), id: \.self){ index in
                    let player = model?.data?.inning2?.players?[index]
                    RuniningView(isShowLine: true,playerName: player?.name ?? "bastsman",
                                 r: "\(player?.runsScored ?? 0)",
                                 b: "\(player?.ballsFaced ?? 0)",
                                 s4: "\(player?.fours ?? 0)",
                                 s6: "\(player?.sixes ?? 0)",
                                 sr: "\(player?.strikeRate ?? 0)")
                }
                
                ZStack{
                    if let extras = model?.data?.inning2?.extras {
                        let totalExtras = (extras.byes ?? 0) +
                        (extras.noBalls ?? 0) +
                        (extras.wides ?? 0) +
                        (extras.legByes ?? 0)
                        
                        Text("Extras \(totalExtras) (b \(extras.byes ?? 0),w \(extras.wides ?? 0),nb \(extras.noBalls ?? 0),lb \(extras.legByes ?? 0))").font(Font.mulishMedium(size: 13)).foregroundColor(Color.textColorGray)
                    }else{
                        Text("Extras 0 (b 0,w 0,nb 0,lb 0)").font(Font.mulishMedium(size: 13)).foregroundColor(Color.textColorGray)
                    }
                }.frame(maxWidth: .infinity).frame(height: 32).background(Color.textFieldColor).cornerRadius(10).padding(.top)
                
                HStack(spacing:0){
                    Text(StringConstants.total).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColorGray)
                    Spacer()
                    Text("\(model?.data?.inning2?.team2Score ?? 0)/\(model?.data?.inning2?.team2Wickets ?? 0) ").font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColorGray)
                    Text("(\(model?.data?.inning2?.totalOvers ?? "0.0"))").font(Font.mulishMedium(size: 13)).foregroundColor(Color.textColorGray)
                }.padding(.horizontal).frame(maxWidth: .infinity).frame(height: 58).background(Color.textFieldColor).cornerRadius(14).padding(.top)
                VStack{
                    RuniningView(changeColor: true, height: 32,
                                 playerName: "Bowlers",
                                 r: "O",
                                 b: "D",
                                 s4: "R ",
                                 s6: "W ",
                                 sr: "ER").padding(.top)
                    ForEach(0..<(model?.data?.inning2?.bowlers?.count ?? 0), id: \.self){ i in
                        let player = model?.data?.inning2?.bowlers?[i]
                        RuniningView(isShowLine: true,
                                     playerName: player?.name ?? "bowlers",
                                     r: "\(player?.overs ?? "0")",
                                     b: "\(player?.dotBalls ?? 0)",
                                     s4: "\(player?.runsConceded ?? 0)",
                                     s6: "\(player?.wicketsTaken ?? 0)",
                                     sr: "\(player?.economyRate ?? 0)")
                        
                    }
                }
            }
        }
    }
}


#Preview {
    CricketScoreCardSummaryView(viewModel: CricketScoreCardSummaryViewModel())
}
