//
//  ProfileSettingsView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 06/05/2024.
//

import SwiftUI


struct ProfileSettingsView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    @State private var showActionSheet = false
    @State private var showImagePicker = false
    @State private var showCameraPermissionAlert = false
    @State private var selectedSourceType: UIImagePickerController.SourceType = .photoLibrary
    var body: some View {
        ZStack{
            
                VStack{
                    HomeSecondaryAppBBar(title: StringConstants.profileSettings, btnBackCallBack:  {
                        viewModel.coordinator?.popNavigationView()
                    }).padding(.top,5)
                    ScrollView(showsIndicators: false){
                    VStack{
                        
                        ZStack{
                            
                            if viewModel.selectedImage == nil{
                                
                                WebImageView(image: "\(UserDefaultsManager.shared.userProfileData?.img ?? "")")
                                    .frame(width: 80,height: 80)
                                    .clipShape(.circle)
                            }else{
                                Image(uiImage: viewModel.selectedImage!)
                                    .resizable()
                                    .frame(width: 80,height: 80)
                                    .clipShape(.circle)
                            }
                            ZStack{
                                Color.green
                                    .frame(width: 20, height: 20)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle().stroke(Color.white, lineWidth: 2)
                                    )
                                Image.ic_profile
                            }.padding(.leading,70)
                                .padding(.top,40)
                        } .padding(.top).onTapGesture {
                            showActionSheet.toggle()
                        }
                        
                        Text(StringConstants.name).font(Font.mulishMedium(size: 18)).padding(.top,15).foregroundColor(Color.textColor) .frame(maxWidth: .infinity, alignment: .leading)
                        AuthTextField(title: StringConstants.name,type: .normalField ,text: $viewModel.fullName)
                        
//                        Text(StringConstants.email).font(Font.mulishMedium(size: 18)).padding(.top,15).foregroundColor(Color.textColor) .frame(maxWidth: .infinity, alignment: .leading)
//                        AuthTextField(title: StringConstants.exampleGmail,type: .normalField ,text: $viewModel.email)
                        
                        Text(StringConstants.password).font(Font.mulishMedium(size: 18)).padding(.top,15).foregroundColor(Color.textColor) .frame(maxWidth: .infinity, alignment: .leading)
                        AuthTextField(title: StringConstants.stars,type: viewModel.showPassword ? .normalField : .secureField ,isPassword: viewModel.showPassword, text: $viewModel.password) {
                             viewModel.showPassword.toggle()
                        }
                        
                        AppButton(title: StringConstants.saveChanges, callBack: {
                            viewModel.btnSaveChanges()
                        }).padding(.top,50)
                        
                    }.padding(.horizontal)
                }
            }
            
            if viewModel.showActivityIndicator {
                ActivityIndicator()
            }
            
        }.showToast(toastText: viewModel.validationText, isShowing: $viewModel.validationAlert,toastType: viewModel.toastType)   .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(title: Text("Choose Image Source"), buttons: [
                .default(Text("Camera")) {
                    Utility.checkCameraPermission { value in
                        if value {
                            selectedSourceType = .camera
                            showImagePicker = true
                            showCameraPermissionAlert = false
                        } else {
                            showCameraPermissionAlert = true
                        }
                    }
                },
                .default(Text("Photo Library")) {
                    selectedSourceType = .photoLibrary
                    showImagePicker = true
                },
                .cancel()
            ])
        }.sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $viewModel.selectedImage, sourceType: selectedSourceType)
        }
    }
}

#Preview {
    ProfileSettingsView(viewModel: ProfileViewModel())
}


