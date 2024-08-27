//
//  ScoringView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 18/07/2024.
//

import SwiftUI

struct CricketScoringView: View {
    
    @ObservedObject var viewModel: CricketScoreCardsViewModel
    
    var body: some View {
        
        ZStack{
            VStack(spacing: 0){
                
                HomeSecondaryAppBBar(coordinator: viewModel.coordinator,title: "Scoring", btnShareCallBack:  {
                    
                }).padding(.top,5)
                
                ScrollView{
                    VStack(spacing: 0){
                        
                        ZStack{
                            Image("download 1").resizable()
                            VStack(spacing: 0){
                                Text(viewModel.matchPlayingTeam).font(Font.mulishMedium(size: 28)).foregroundColor(Color.white).frame(maxWidth: .infinity,alignment: .leading).padding(.top,20).padding(.leading)
                                
                                HStack{
                                    Text(viewModel.totleScoreTeam1).font(Font.mulishMedium(size: 28)).foregroundColor(Color.white)
                                    Text("(\(viewModel.cricketScorecard?.currentOver ?? 0).\(viewModel.cricketScorecard?.currentBall ?? 0)/\(viewModel.noOfOvers))").font(Font.mulishMedium(size: 15)).foregroundColor(Color.white)
                                    
                                }.padding(.top,40)
                                Text("\(viewModel.tosswinnerid == 0 ? "Team A" : "Team B") won the toss and selected to \(viewModel.tossdecision == 0 ? "bat" : "bowl") ")
                                    .font(Font.mulishMedium(size: 15)).foregroundColor(Color.white)
                                Color.clear.frame(height: 100)
                                ZStack(alignment: .top){
                                    VStack{
                                        Color.white.frame(height: 1)
                                        Spacer()
                                    }
                                    Color.white.frame(width: 1)
                                    HStack{
                                        VStack(alignment: .leading,spacing: 0){
                                            
                                            Text(viewModel.striker?.fullName ?? "").font(Font.mulishMedium(size: 20)).foregroundColor(Color.white)
                                            Text(viewModel.scorePlayer1).font(Font.mulishMedium(size: 15)).foregroundColor(Color.white)
                                        }.padding(.top)
                                        
                                        Spacer()
                                    }.padding(.horizontal).padding(.leading)
                                    VStack(alignment: .leading,spacing: 0){
                                        
                                        Text(viewModel.nonStriker?.fullName ?? "").font(Font.mulishMedium(size: 20)).foregroundColor(Color.white)
                                        Text(viewModel.scorePlayer2).font(Font.mulishMedium(size: 15)).foregroundColor(Color.white)
                                    }.padding(.leading,120).padding(.top)
                                    
                                }.frame(height: 180)
                                
                            }
                            
                            
                            VStack{
                                Spacer()
                                HStack{
                                    VStack(alignment: .leading){
                                        VStack(spacing: 10){
                                            HStack{
                                                Image("XMLID_189_")
                                                Text(viewModel.striker?.fullName ?? "").font(Font.mulishMedium(size: 20)).foregroundColor(Color.white)
                                                Image("fi_7513899")
                                                Spacer()
                                            }
                                            
                                            ScrollView(.horizontal){
                                                HStack{
                                                    ForEach(0..<viewModel.runsList.count, id: \.self) { index in
                                                        VStack {
                                                            Text("\(viewModel.runsList[index].runs ?? 0)")
                                                                .font(Font.system(size: 15))
                                                                .frame(width: 25, height: 25)
                                                                .foregroundColor(Color.black)
                                                                .background(
                                                                    viewModel.runsList[index].runs ?? 0 == 4 ? Color.yellow :
                                                                        viewModel.runsList[index].runs ?? 0 == 6 ? Color.green :
                                                                        viewModel.extreBall(index: index) ? Color.gray : Color.white
                                                                )
                                                                .clipShape(Circle())
                                                            
                                                            Text(viewModel.balltype(index: index))
                                                                .font(Font.system(size: 12))
                                                                .foregroundColor(Color.gray)
                                                        }
                                                        .frame(width: 25, height: 45)
                                                    }
                                                    
                                                }
                                                
                                            }
                                        }.padding(.top,2).padding(.leading,5).padding(.trailing,10)
                                    }
                                    
                                    Spacer()
                                    VStack{
                                        Text(viewModel.keeper?.fullName ??  "").font(Font.mulishMedium(size: 15)).foregroundColor(Color.white)
                                        Spacer()
                                        Text("Change Keeper").font(Font.mulishMedium(size: 12)).foregroundColor(Color.appGreenColor).onTapGesture {
                                            viewModel.showBowlingListForNewBowler = 2
                                        }
                                    }.padding(.vertical)
                                }.padding(.horizontal).frame(maxWidth: .infinity).frame(height: 100).background(Color.accountTextColor)
                            }
                        }.frame(maxWidth: .infinity)
                            .frame(height: UIScreen.main.bounds.height/2).background(Color.gray)
                        
                        HStack(spacing: 0){
                            VStack(spacing: 0){
                                HStack(spacing: 0){
                                    ScoringButton(){
                                        viewModel.addScore(run: nil)
                                    }
                                    ScoringButton(text:"1") {
                                        viewModel.addScore(run: 1)
                                        
                                    }
                                    ScoringButton(text:"2") {
                                        viewModel.addScore(run: 2)
                                    }
                                    
                                }
                                HStack(spacing: 0){
                                    ScoringButton(text:"3") {
                                        
                                        viewModel.addScore(run: 3)
                                    }
                                    ScoringButton(text:"4",six: "Four") {
                                        viewModel.addScore(run: 4)
                                    }
                                    ScoringButton(text:"6", six: "six") {
                                        viewModel.addScore(run: 6)
                                    }
                                }
                                
                                HStack(spacing: 0){
                                    ScoringButton(text:"WB",fontSize:24,bg:Color.textFieldColor,callBack: {
                                        viewModel.btnWB.toggle()
                                    })
                                    
                                    ScoringButton(text:"NB",fontSize:24,bg:Color.textFieldColor,callBack: {
                                        viewModel.btnNB.toggle()
                                    })
                                    
                                    ScoringButton(text:"BYE",fontSize:24,bg:Color.textFieldColor,callBack: {
                                        viewModel.btnBYB.toggle()
                                    })
                                    
                                }
                            }
                            
                            VStack(spacing: 0){
                                ScoringButton2(text:"UNDO",bg:Color.textFieldColor,fg:.appGreen,call: {
                                    let mode = UndoReq(match_id: viewModel.nearbyMatchesitem?.id)
                                    viewModel.undoCricketAction(model: mode)
                                })
                                ScoringButton2(text:"5,7",bg:Color.textFieldColor,call: {
                                    viewModel.btnRun.toggle()
                                })
                                ScoringButton2(text:"OUT",bg:Color.textFieldColor,fg:.red,call: {
                                    viewModel.btnOutClick()
                                })
                                ScoringButton2(text:"LB",bg:Color.textFieldColor,call: {
                                    viewModel.btnLB.toggle()
                                })
                            }
                            
                        }.frame(maxWidth: UIScreen.main.bounds.width)
                    }
                }
            }
            if viewModel.btnWB{
                ButtomShett(viewModel: viewModel).edgesIgnoringSafeArea(.all)
            }
            if viewModel.btnNB{
                ButtomShett(viewModel: viewModel,title: "NB +").edgesIgnoringSafeArea(.all)
            }
            if viewModel.btnBYB{
                ButtomShett(viewModel: viewModel,title: "BYE +").edgesIgnoringSafeArea(.all)
            }
            if viewModel.btnLB{
                ButtomShett(viewModel: viewModel,title: "").edgesIgnoringSafeArea(.all)
            }
            if viewModel.btnRun{
                RunsScoredByRunningShett(viewModel: viewModel).edgesIgnoringSafeArea(.all)
            }
            

            
            if viewModel.showBatingPlayerList != 0 {
                PlayerListView(title:"Selecet Batting player",userList: viewModel.tempBattingTeamPlayers,
                               temUserList: viewModel.tempBattingTeamPlayers,
                               callBack: {user,index in
                    viewModel.tempBattingTeamPlayers[index].isSelected!.toggle()
                    if viewModel.showBatingPlayerList == 1{
                        viewModel.striker = user
                    }else{
                        viewModel.nonStriker = user
                    }
                    viewModel.tempBattingTeamPlayers.remove(at: index)
                    self.viewModel.showBatingPlayerList = 0
                    
                },btnBackcallBack:{
                    viewModel.showBatingPlayerList = 0
                })
            }
            

            
        if viewModel.showBowlingListForNewBowler != 0{
            PlayerListView(title: viewModel.showBowlingListForNewBowler == 1 ? "Chanage Bowler" : "Change Keeper" ,userList: viewModel.tempBowlingTeamPlayers,temUserList:  viewModel.tempBowlingTeamPlayers, callBack: {user,index in
                viewModel.tempBowlingTeamPlayers[index].isSelected!.toggle()
                if viewModel.showBowlingListForNewBowler == 1{
                    viewModel.bowler = user
                }else{
                    viewModel.keeper = user
                }
                self.viewModel.showBowlingListForNewBowler = 0
            },btnBackcallBack:{
                viewModel.showBowlingListForNewBowler = 0
            }).onAppear(){
                viewModel.removeSelectedPlayerFormBowlingList()
            }
        }
           
        }.showToast(toastText: viewModel.validationText, isShowing: $viewModel.validationAlert,toastType: viewModel.toastType)
            .onAppear{
                if !viewModel.viewWillAppear{
                    viewModel.isViewWillAppearFirst()
                    viewModel.viewWillAppear = true
                }
            }
    }
}

#Preview {
    CricketScoringView(viewModel: CricketScoreCardsViewModel())
}

struct wideBallShett: View {
 
    var body: some View {
        ZStack(alignment: .bottom){
            Color.black.opacity(0.3).ignoresSafeArea(.all)
            
            VStack{
                HStack(spacing: 1){
                    Text("Wide Ball").font(Font.mulishMedium(size: 32)).foregroundColor(Color.textColor)
           
                }.padding(.top,10)
                
                HStack(spacing: 15){
                    TextField("", text: .constant(""))
                }.frame(width: 100,height: 40).overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.textColorGray, lineWidth: 1)).padding(.top,5)
          
                HStack(spacing: 20){
                    
                    Text("title")
                        .frame(maxWidth: 150)
                        .frame(height: 45)
                        .foregroundColor(Color.appGreenColor)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.appGreenColor, lineWidth: 1))
                       
                        .font(.mulishSemiBold(size: 20.0))
                    
                    ZStack {
                        Text("title")
                            .frame(maxWidth: 150)
                            .frame(height: 45)
                            .foregroundColor(Color.white)
                            .background(Color.appGreen)
                            .cornerRadius(10)
                            .font(.mulishSemiBold(size: 20.0))
                        
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white.opacity(0.3), lineWidth: 3) // Adjust opacity as needed
                            .shadow(color: .white, radius: 10, x: 0, y: 0)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(1) // Adjust padding to control the size of the shadow
                    } .frame(maxWidth: 150).frame(height: 40)
                  
                }.padding(.top)
              Spacer()
            }.frame(maxWidth: .infinity).frame(height: 210).background(Color.white).cornerRadius(20, corners: [.topLeft,.topRight])
        }
    }
}


struct noBallShett: View {
 
    var body: some View {
        ZStack(alignment: .bottom){
            Color.black.opacity(0.3).ignoresSafeArea(.all)
            
            VStack{
                HStack(spacing: 1){
                    Text("No Ball").font(Font.mulishMedium(size: 32)).foregroundColor(Color.textColor)
           
                }.padding(.top,10)
                
                HStack(spacing: 15){
                    TextField("", text: .constant(""))
                }.frame(width: 100,height: 40).overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.textColorGray, lineWidth: 1)).padding(.top,5)
          
                HStack(spacing: 20){
                    
                    Text("title")
                        .frame(maxWidth: 150)
                        .frame(height: 45)
                        .foregroundColor(Color.appGreenColor)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.appGreenColor, lineWidth: 1))
                       
                        .font(.mulishSemiBold(size: 20.0))
                    
                    ZStack {
                        Text("title")
                            .frame(maxWidth: 150)
                            .frame(height: 45)
                            .foregroundColor(Color.white)
                            .background(Color.appGreen)
                            .cornerRadius(10)
                            .font(.mulishSemiBold(size: 20.0))
                        
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white.opacity(0.3), lineWidth: 3) // Adjust opacity as needed
                            .shadow(color: .white, radius: 10, x: 0, y: 0)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(1) // Adjust padding to control the size of the shadow
                    } .frame(maxWidth: 150).frame(height: 40)
                  
                }.padding(.top)
              Spacer()
            }.frame(maxWidth: .infinity).frame(height: 210).background(Color.white).cornerRadius(20, corners: [.topLeft,.topRight])
        }
    }
}


struct RunsScoredByRunningShett: View {
   
    var viewModel: CricketScoreCardsViewModel
    @State var txt = ""
    var body: some View {
        ZStack(alignment: .bottom){
            Color.black.opacity(0.3).ignoresSafeArea(.all).onTapGesture {
                viewModel.btnRun = false
            }
            
            VStack{
                HStack(spacing: 1){
                    Text("Leg Bye Runs").font(Font.mulishMedium(size: 32)).foregroundColor(Color.textColor)
           
                }.padding(.top,10)
                
                HStack(spacing: 15){
                    TextField("", text: $txt).padding().keyboardType(.numberPad)
                }.frame(width: 100,height: 40).overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.textColorGray, lineWidth: 1)).padding(.top,5)
                Text("*4 and 6 will not be considered boundaries.").font(Font.mulishMedium(size: 12)).foregroundColor(Color.textColorGray).padding(.vertical,15)
                HStack(spacing: 20){
                    
                    Text("Cancle")
                        .frame(maxWidth: 150)
                        .frame(height: 45)
                        .foregroundColor(Color.appGreenColor)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.appGreenColor, lineWidth: 1))
                       
                        .font(.mulishSemiBold(size: 20.0))
                        .onTapGesture {
                            viewModel.btnRun = false
                        }
                    ZStack {
                        Text("ok")
                            .frame(maxWidth: 150)
                            .frame(height: 45)
                            .foregroundColor(Color.white)
                            .background(Color.appGreen)
                            .cornerRadius(10)
                            .font(.mulishSemiBold(size: 20.0))
                        
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white.opacity(0.3), lineWidth: 3) // Adjust opacity as needed
                            .shadow(color: .white, radius: 10, x: 0, y: 0)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(1) // Adjust padding to control the size of the shadow
                    } .frame(maxWidth: 150).frame(height: 40)
                        .onTapGesture {
                            
                            viewModel.addScore(run: Int(txt))
                            viewModel.btnRun = false
                        }
                }.padding(.bottom)
              Spacer()
            }.frame(maxWidth: .infinity).frame(height: 260).background(Color.white).cornerRadius(20, corners: [.topLeft,.topRight])
        }
    }
}

struct LegRunShett: View {
 
    var body: some View {
        ZStack(alignment: .bottom){
            Color.black.opacity(0.3).ignoresSafeArea(.all)
            
            VStack{
                HStack(spacing: 1){
                    Text("Leg Bye Runs").font(Font.mulishMedium(size: 32)).foregroundColor(Color.textColor)
           
                }.padding(.top,10)
                
                HStack(spacing: 15){
                    ByRunButton(text: "1",action: {})
                    ByRunButton(text: "2",action: {})
                    ByRunButton(text: "3",action: {})
                    ByRunButton(text: "4",action: {})
                    ByRunButton(text: "+",action: {})
                    HStack(spacing: 15){
                        TextField("", text: .constant(""))
                    }.frame(width: 50,height: 38).overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.textColorGray, lineWidth: 1)).padding(.top,5)
                    
                }.padding(.top,25)
              Spacer()
            }.frame(maxWidth: .infinity).frame(height: 220).background(Color.white).cornerRadius(20, corners: [.topLeft,.topRight])
        }
    }
}

struct ByRunShett: View {
 
    var body: some View {
        ZStack(alignment: .bottom){
            Color.black.opacity(0.3).ignoresSafeArea(.all)
            
            VStack{
                HStack(spacing: 1){
                    Text("Bye Runs").font(Font.mulishMedium(size: 32)).foregroundColor(Color.textColor)
           
                }.padding(.top,10)
                
                HStack(spacing: 15){
                    ByRunButton(text: "1",action: {})
                    ByRunButton(text: "2",action: {})
                    ByRunButton(text: "3",action: {})
                    ByRunButton(text: "4",action: {})
                    ByRunButton(text: "+",action: {})
                    HStack(spacing: 15){
                        TextField("", text: .constant(""))
                    }.frame(width: 50,height: 38).overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.textColorGray, lineWidth: 1)).padding(.top,5)
                    
                }.padding(.top,25)
              Spacer()
            }.frame(maxWidth: .infinity).frame(height: 210).background(Color.white).cornerRadius(20, corners: [.topLeft,.topRight])
        }
    }
}



struct ButtomShett: View {
    var viewModel: CricketScoreCardsViewModel
    @State var show = false
    @State var run = ""
    var title = "WD +"
    var body: some View {
        ZStack(alignment: .bottom){
            Color.black.opacity(0.3).ignoresSafeArea(.all).onTapGesture {
                offShee()
            }
            
            VStack{
                HStack(spacing: 1){
                    Text("Wide Ball").font(Font.mulishMedium(size: 32)).foregroundColor(Color.textColor)
                    Text("(WD=1)").font(Font.mulishMedium(size: 12)).foregroundColor(Color.textColor).padding(.top,7)
                }
              
                    HStack(spacing: 5){
                        WideBallButton(text: "\(title) 0",action: {
                            viewModel.addScoreWithExtraBall(run: nil, ballType: getBallType())
                            offShee()
                        })
                        WideBallButton(text: "\(title) 1",action: {
                            viewModel.addScoreWithExtraBall(run: 1, ballType: getBallType())
                            offShee()
                            
                        })
                        WideBallButton(text: "\(title) 2",action: {
                            viewModel.addScoreWithExtraBall(run: 2, ballType: getBallType())
                            offShee()
                        })
                        WideBallButton(text: "\(title) 3",action: {
                            viewModel.addScoreWithExtraBall(run: 3, ballType: getBallType())
                            offShee()
                        })
                    }.padding(.bottom,5)
                if !show{
                    HStack(spacing: 5){
                        WideBallButton(text: "\(title) 4",action: {
                            viewModel.addScoreWithExtraBall(run: 4, ballType: getBallType())
                            offShee()
                        })
                        WideBallButton(text: "\(title) 5",action: {
                            viewModel.addScoreWithExtraBall(run: 5, ballType: getBallType())
                            offShee()
                        })
                        WideBallButton(text: "\(title) 6",action: {
                            viewModel.addScoreWithExtraBall(run: 6, ballType: getBallType())
                            offShee()
                        })
                        WideBallButton(text: "+",action: {
                            show.toggle()
                        })
                        
                    }.frame(height: 41).padding(.bottom)
                   
                }else{
                    
                     HStack{
                         TextField("Runs", text: $run).padding().font(Font.mulishMedium(size: 16)).frame(width: 200,height: 41).background(Color.textFieldColor).overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.appGreenColor, lineWidth: 1))
                         WideBallButton(text: "ok",action: {
                             viewModel.addScoreWithExtraBall(run: Int(run), ballType: getBallType())
                             offShee()
                         })
                         
                     }
                }
            }.frame(maxWidth: .infinity).frame(height: 220).background(Color.white).cornerRadius(20, corners: [.topLeft,.topRight])
        }
    }
    
    func getBallType() ->String{
        var type = ""
        if viewModel.btnWB{
            type = "wide"
        }else if viewModel.btnBYB{
            type = "bye"
        }else if viewModel.btnNB{
            type = "no_ball"
        }else if viewModel.btnLB{
            type = "leg_bye"
        }
        return type
    }
    
    func offShee(){
        viewModel.btnWB = false
        viewModel.btnBYB = false
        viewModel.btnNB = false
        viewModel.btnRun = false
        viewModel.btnLB = false
    }
}


struct ScoringButton: View {
    var text:String = "0"
    var six:String? = nil
    var fontSize:CGFloat = 32
    var bg:Color = .white
    var fg:Color = .gray
    var callBack:(()->Void)?
    var body: some View {
        Button(action: {
            callBack?()
        }, label: {
        VStack{
            Text(text).font(Font.mulishMedium(size: fontSize)).foregroundColor(Color.gray).padding(.top, six != nil ? 16 : 0)
            if six != nil{
                Text(six ?? "").font(Font.mulishMedium(size: 12)).foregroundColor(Color.gray)
            }
        }.frame(width: 107,height: 100).background(bg).overlay(
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color.appGrayColor, lineWidth: 1))
        })
    }
}

struct ScoringButton2: View {
    var text:String = "0"
    var bg:Color = .white
    var fg:Color = .gray
    var call:(()->Void)?
    var body: some View {
        Button(action: {
            call?()
        }, label: {
           
       
        VStack{
            Text(text).font(Font.mulishMedium(size: 16)).foregroundColor(fg)
            
        }.frame(width: 107,height: 75).background(bg).overlay(
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color.appGrayColor, lineWidth: 1))
        })
    }
}


struct WideBallButton: View {
    var text:String = "WD + 0"
    var bg:Color = .white
    var fg:Color = .appGreenColor
    
    var action:(()->Void)?
    var body: some View {
        Button(action: {
            action?()
        }, label: {
           
       
        VStack{
            Text(text).font(Font.mulishMedium(size: 16)).foregroundColor(fg)
            
        }.frame(width: 82,height: 41).background(bg).overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.appGreenColor, lineWidth: 1))
        })
    }
}
struct ByRunButton: View {
    var text:String = "WD + 0"
    var bg:Color = .white
    var fg:Color = .appGreenColor
    
    var action:(()->Void)?
    var body: some View {
        Button(action: {
            action?()
        }, label: {
           
       
        VStack{
            Text(text).font(Font.mulishMedium(size: 16)).foregroundColor(fg)
            
        }.frame(width: 40,height: 40).background(bg).overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.appGreenColor, lineWidth: 1))
        })
    }
}

