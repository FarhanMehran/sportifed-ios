//
//  OutTypeView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 03/08/2024.
//

import SwiftUI

struct OutTypeView: View {
    var list = ["Bowled", "Caught", "Caught Behind", "Caught & Bowled", "Stumped", "Run Out", "LBW", "Hit Wicket", "Retired Hurt",
                "Retired Out", "Run Out (Mankaded)", "Absent Hurt", "Hit the Ball Twice",
                "Obstr. the Field", "Timed Out", "Retired"]
    
    @ObservedObject var viewModel: OutTypeViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                HomeSecondaryAppBBar(coordinator: viewModel.coordinator, title: "Out How?", btnShareCallBack: {
                    
                }).padding(.top, 5)
                
                // Make 4 item grid with loop
                ForEach(0..<5) { row in
                    HStack (spacing: 0){
                        ForEach(0..<4) { col in
                            let itemIndex = row * 4 + col
                            if itemIndex < list.count {
                                VStack(spacing: 0) {
                                    Image(list[itemIndex])
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                    
                                        .overlay(
                                            Circle().stroke(Color.gray, lineWidth: 1)
                                        )
                                    
                                    Text(list[itemIndex])
                                        .foregroundColor(.textColor)
                                        .font(.mulishRegular(size: 14.0))
                                        .frame(width: 60, height: 60)
                                        
                                }
                                .frame(width: 90, height: 100)
                                
                                .onTapGesture {
                                    viewModel.outTypeCallBack(list[itemIndex])
                                    viewModel.coordinator?.popNavigationView()
                                }
                            }
                        }
                    }
                }.padding(.top,20)
            }
        }
    }
}


#Preview {
    OutTypeView(viewModel: OutTypeViewModel())
}
