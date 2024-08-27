//
//  CustomDropDown.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 15/08/2024.
//

import SwiftUI
struct SelectedDate{
    var name:String
    var isSelected:Bool = false
}

struct CustomDropDown: View {
    var title:String = ""
    @Binding var isShow:Bool
    var list:[SelectedDate]?
    var callBack:((String,Int)->Void)?
    
    var body: some View {
        VStack(spacing: 0){
            VStack{
                HStack {
                    Text(title).foregroundColor(Color.textColorGray).font(Font.mulishMedium(size: 14)).frame(height: 10)
                    Spacer()
                    
                    
                    Image.ic_arrowDown
                    
                }.padding()
          
                if isShow{
                    Color.appGreenColor.frame(height: 1)
                }
            }.frame(height: isShow ? 59 : 50)
         
            if isShow{
                VStack{
                    if let list = list{
                        ForEach(0..<list.count, id: \.self){ index in
                            let item = list[index]
                            HStack(spacing:0){
                                
                                ZStack{
                                    Color(item.isSelected ? .appGreen : .clear)
                                        .frame(width: item.isSelected ? 14.3 : 14 ,height: item.isSelected ? 15.8 : 14)
                                        .overlay(RoundedRectangle(cornerRadius: 0, style: .continuous)
                                            .stroke(Color.textColorGray, lineWidth:item.isSelected ? 0 : 1.5))
                                    
                                    Image.ic_Tick.resizable().frame(width: 8,height: 7)
                                    //}
                                }.frame(width: 15).padding(.horizontal)
                                Text(item.name)
                                    .foregroundColor(Color.textColorGray)
                                    .font(Font.mulishRegular(size: 18))
                                Spacer()
                            }.padding(.vertical,4).background(Color.gray.opacity(0.001)).onTapGesture {
                                callBack?(item.name,index)
                            }
                        }
                    }
                }.padding(.bottom)
            }
            
        }.background(Color.textFieldColor).cornerRadius(10).onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
                isShow.toggle()
            }
        }
    }
}

#Preview {
    FootballScoreCardView(viewModel: FootballScoreCardViewModel())
}
