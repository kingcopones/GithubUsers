//
//  UsersViewModel.swift
//  GithubUsers
//
//  Created by King Copones on 10/25/21.
//

import Foundation

class UsersViewModel: ObservableObject {
    @Published var users: [User] = []
    func fetchUsers() {
        guard let url = URL(string: "https://api.github.com/users") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url){ [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            //Convert to JSON
            do {
                let user = try JSONDecoder().decode([User].self, from: data)
                DispatchQueue.main.async {
                    self?.users = user
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
}
