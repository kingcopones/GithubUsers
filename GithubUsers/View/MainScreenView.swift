//
//  MainScreenView.swift
//  GithubUsers
//
//  Created by King Copones on 10/25/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct MainScreenView: View {
    @StateObject var vm = UsersViewModel()
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(vm.users, id: \.self){i in
                        HStack(spacing: 15){
                            AsyncImage(url: URL(string: i.avatarURL!), scale: 1.0){ phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50, height: 50)
                                    
                                }else {
                                    ShimmerCardView()
                                        .frame(width: 50, height: 50)
                                }
                            }
                            Text(i.login!)
                        }
                    }
                }.navigationTitle("Github Users")
                    .onAppear{
                        vm.fetchUsers()
                    }.refreshable {
                        vm.fetchUsers()
                    }
            }
        }
    }
}

@available(iOS 15.0, *)
struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
