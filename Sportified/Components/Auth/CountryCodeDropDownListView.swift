//
//  CountryCodeDropDownListView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 15/05/2024.
//

import SwiftUI

struct CountryCodeDropDownListView: View {
    
    var title: String
    var filterList: [RegionCountryCode] = Utility.getRegionCountryCode()
    @Binding var selectedText: String
    let callBack: ((RegionCountryCode) -> Void)
    @State private var searchText: String = ""
    @State private var isEditing = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
          DropDownTitle(text: title)
            
            HStack {
                TextField("search", text: $searchText)
                    .frame(height: 30)
                    .padding(7)
                    .padding(.horizontal, 30)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        self.isEditing = true
                    }.overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20)
                            
                            if isEditing {
                                Button(action: {
                                    self.searchText = ""
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 20)
                                }
                            }
                        }
                    )
                
                if isEditing {
                    Button(action: {
                        //self.isEditing = false
                        self.searchText = ""
                        hideKeyboard()
                    }) {
                        Text("Cancel")
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.easeInOut(duration: 0.3), value: 1.0)
                }
            }.padding(.horizontal, 10)
            
            let filteredList = searchText.isEmpty ? filterList : filterList.filter{ ($0.name ?? "").localizedCaseInsensitiveContains(searchText) }
            
            if filteredList.count > 0 {
                List {
                    ForEach(filteredList.indices, id: \.self) { data in
                        HStack {
                            Button {
                                
//                                self.searchText = ""
//                                typeWriterAnimation(optionSelected: "\(filteredList[data].flag ?? "") \(filteredList[data].dialCode ?? "")")
                                
                                hideKeyboard()
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    callBack(filteredList[data])
                                }
                                
                            } label: {
                                HStack(spacing: 10) {
                                    Text(filteredList[data].flag ?? "")
                                    Text(filteredList[data].name ?? "")
                                    Spacer()
                                    Text(filteredList[data].dialCode ?? "")
                                }
                            }
                
                        }
                    }
                }.listStyle(PlainListStyle()).padding(.trailing, 20)
            } else {
                VStack(alignment: .center) {
                    Spacer()
                    Text("No Record Found").font(Font.mulishBold(size: 20)).foregroundColor(Color.textColor).padding(20).offset(y: -24)
                    Spacer()
                }.frame(maxWidth: .infinity)
            }
            
        }
        
    }
    
  
}

#Preview {
    CountryCodeDropDownListView(title: "StringConstants.selectGender", filterList: Utility.getRegionCountryCode(), selectedText: .constant("") , callBack: { _ in
        print(StringConstants.gameType)
    })
}
