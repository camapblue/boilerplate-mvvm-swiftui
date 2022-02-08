//
//  ContactDetailScreen.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/31/21.
//

import SwiftUI
import Repository
import POC_Common_UI_iOS

struct ContactDetailScreen: View {
    @EnvironmentObject private var viewModel: ContactDetailViewModel
    
    var body: some View {
        let contact = viewModel.contact
        
        ZStack {
            VStack {
                Rectangle().fill(Color.clear).frame(height: 20)
                AvatarView(avatar: contact.avatar, size: 128)
                Rectangle().fill(Color.clear).frame(height: 44)
                HStack {
                    SpacerView(width: 48)
                    if viewModel.editingFirstName.isEmpty && viewModel.editingLastName.isEmpty {
                        Text(contact.fullName())
                            .primaryBold(fontSize: 20)
                    } else {
                        HStack {
                            TextField("Input first name", text: $viewModel.editingFirstName)
                                .padding(4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0))
                                )
                                .padding(4)
                            SpacerView(width: 16)
                            TextField("Input last name", text: $viewModel.editingLastName)
                                .padding(4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0))
                                )
                                .padding(4)
                        }
                    }
                    SpacerView(width: 16)
                    if viewModel.editingFirstName.isEmpty && viewModel.editingLastName.isEmpty {
                        Button(action: {
                            viewModel.editBtnPressed()
                        }) {
                            Image("ico_edit")
                                .renderingMode(.original)
                        }
                    } else {
                        SpacerView(width: 32)
                    }
                }
                .frame(height: 44)
                Rectangle().fill(Color.clear).frame(height: 44)
                HStack(alignment: .firstTextBaseline) {
                    Text("address:")
                        .primaryRegular(fontSize: 15, color: .gray)
                        .frame(width: 100, alignment: .trailing)
                    Rectangle().fill(Color.clear).frame(width: 10, height: 20)
                    Text(contact.fullAddress())
                        .primaryRegular(fontSize: 17)
                    Spacer()
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                HStack {
                    Text("age:")
                        .primaryRegular(fontSize: 15, color: .gray)
                        .foregroundColor(.gray)
                        .frame(width: 100, alignment: .trailing)
                    Rectangle().fill(Color.clear).frame(width: 10, height: 20)
                    Text("\(contact.age())")
                        .primaryRegular(fontSize: 17)
                        .foregroundColor(.black)
                    Spacer()
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                Spacer()
                ButtonView.primary("Update Contact", disabled: !viewModel.updateBtnEnable ) {
                    viewModel.updateBtnPressed()
                }
                .padding(.horizontal, 32)
                SpacerView(height: 32)
            }
        }
        .navigationTitle(contact.firstName)
    }
}

struct ContactDetailScreen_Previews: PreviewProvider {
    static var contact = Contact.fakeContact()
    
    static var previews: some View {
        return ContactDetailScreen()
            .frame(width: 375)
    }
}
