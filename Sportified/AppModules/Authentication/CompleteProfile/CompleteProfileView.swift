//
//  CompleteProfileView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 01/05/2024.
//

import SwiftUI

struct CompleteProfileView: View {
    
    @ObservedObject var viewModel: CompleteProfileViewModel
 
    var body: some View {
        ZStack{
            ScrollView(showsIndicators: false){
                VStack{
                    VStack(alignment: .leading,spacing: 3){
                        
                        Text(StringConstants.completeYourProfile).font(Font.mulishMedium(size: 28)).foregroundColor(Color.textColor).padding(.top,10)
                        
                        Text(StringConstants.giveTheInformation).font(Font.mulishRegular(size: 15)).foregroundColor(Color.textColorGray)
                        
                        HStack(spacing: 2){
                            Text(StringConstants.name).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
                            Text("*").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                        }.padding(.top,35)
                        
                        AuthTextField(title: StringConstants.exWilliam,type: .normalField ,text: $viewModel.userName).padding(.top,5)
                        
                        HStack(spacing: 2){
                            Text(StringConstants.accountType).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
                            Text("*").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                        }.padding(.top,25)
                        
                        AppButton(title: viewModel.accountType,buttonType: .dropDown, callBack: {
                            viewModel.showDropDown.toggle()
                        })
                        
                        
                        HStack(spacing: 2){
                            Text(StringConstants.favoriteSports).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
                            Text("*").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                        }.padding(.top,25)
                        
                        FavoriteSportsView(favoriteSportsList: viewModel.favoriteSportsList,callBack: { index in
                            viewModel.favoriteSportsList?[index].isSelected?.toggle()
                            if viewModel.favoriteSportsList?[index].isSelected ?? false {
                                // If the item is selected, append its index to favoriteSportsID
                                viewModel.favoriteSportsID?.append(viewModel.favoriteSportsList?[index].id ?? 0)
                                
                            } else {
                                // If the item is deselected, remove its index from favoriteSportsID
                                if let idToRemove = viewModel.favoriteSportsList?[index].id,
                                   let indexToRemove = viewModel.favoriteSportsID?.firstIndex(of: idToRemove) {
                                    viewModel.favoriteSportsID?.remove(at: indexToRemove)
                                }
                            }
                            
                        })
                        
                        
                        Text(StringConstants.selectLeastoneSportProceed).font(Font.mulishMedium(size: 13)).foregroundColor(Color.textColorGray)
                            .padding(.top,10)
                        
                        HStack(spacing: 2){
                            Text(StringConstants.phoneNumber).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
                            Text("*").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                        }.padding(.top,25)
                        
                        HStack {
                            HStack{
                                Text(viewModel.selectedCountryCode).font(Font.mulishRegular(size: 14)).foregroundColor(Color.textColorGray)
                                Image.ic_arrowDown
                                Color.textColorGray.frame(width: 1,height: 38)
                            }.onTapGesture {
                                viewModel.showCountryCodePicker.toggle()
                            }
                            TextField(StringConstants.enterPhoneNumber, text: $viewModel.userPhoneNumber).foregroundColor(Color.textColorGray).font(Font.mulishMedium(size: 14))
                                .onChange(of: self.viewModel.userPhoneNumber, perform: { value in
                                    if value.count > 12 {
                                        self.viewModel.userPhoneNumber = String(value.prefix(12))
                                    }
                                }).onChange(of: self.viewModel.userPhoneNumber, perform: { newValue in
                                    self.viewModel.userPhoneNumber = newValue.applyPatternOnNumbers(pattern: Utility.mobileNoPattern, replacementCharacter: Utility.mobileNoPatternReplace)
                                })
                            
                        }.padding().frame(height: 65).background(Color.textFieldColor).cornerRadius(10).padding(.top,5).popover(isPresented: $viewModel.showCountryCodePicker) {
                            CountryCodeDropDownListView(title: StringConstants.selectCountryCode, filterList: viewModel.mobileCountryRegion, selectedText:.constant("")) { countryCode in
                                viewModel.selectedCountryCode = countryCode.dialCode ?? "+92"
                                viewModel.showCountryCodePicker.toggle()
                            }
                        }

                        
                        AppButton(title: StringConstants.continues, callBack: {
                            viewModel.btnContinue()
                            // print(viewModel.favoriteSportsID)
                        }).padding(.top,55)
                        
                        Spacer()
                        
                    }
                }.padding(.horizontal).popover(isPresented: $viewModel.showDropDown) {
                    VStack(spacing: 20){
                        Button(action: {
                            viewModel.accountType = StringConstants.organizer
                            viewModel.showDropDown.toggle()
                        }, label: {
                            Text(StringConstants.organizer).font(Font.mulishBold(size: 18)).foregroundColor(Color.textColor).frame(maxWidth: .infinity,alignment: .leading)
                        })
                        Button(action: {
                            viewModel.accountType = UserType.user.rawValue
                            viewModel.showDropDown.toggle()
                        }, label: {
                            Text("User").font(Font.mulishBold(size: 18)).foregroundColor(Color.textColor).frame(maxWidth: .infinity,alignment: .leading)
                        })
                        Spacer()
                    }.padding(.horizontal).padding(.top)
                }
               
            }
            if viewModel.showActivityIndicator {
                ActivityIndicator()
            }
        }.showToast(toastText: viewModel.validationText, isShowing: $viewModel.validationAlert).onAppear{
            viewModel.selectedCountryCode = viewModel.mobileCountryRegion[0].dialCode ?? "+92"
            viewModel.getSports()
        }
    }
}

#Preview {
    CompleteProfileView(viewModel: CompleteProfileViewModel())
}


