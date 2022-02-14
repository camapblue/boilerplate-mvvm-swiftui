//
//  ContactListScreen.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/31/21.
//

import SwiftUI
import Repository
import POC_Common_UI_iOS

struct ContactListScreen: View {
    @EnvironmentObject private var viewModel: ContactListViewModel
    
    @Environment(\.router) var router
    
    var body: some View {
        LoadListView<Contact>(pullToRefresh: true, isLoadMore: false) { contact in
            return AnyView(
                Button(action: {
                    router.push(link: .contactDetails(with: contact))
                }, label: {
                    ContactRowItem(contact: contact)
                })
            )
        } itemKey: {
            return $0.id + $0.fullName()
        }
        .environmentObject(viewModel as LoadListViewModel<Contact>)
        .navigationTitle("Contacts")
    }
}

struct ContactRowItem: View {
    var contact: Contact
    
    var body: some View {
        HStack(alignment: .center) {
            AvatarView(avatar: contact.avatar, size: 32)
            VStack(alignment: .leading) {
                Text(contact.fullName())
                    .primaryBold(fontSize: 15)
                Text("age: \(contact.age())")
                    .secondaryRegular(color: .gray)
            }
            .foregroundColor(.black)
            Spacer()
        }
        .frame(minHeight: 44, maxHeight: 44, alignment: .center)
    }
}

struct ContactListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContactListScreen()
    }
}
