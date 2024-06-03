import Foundation

struct User : Codable{
    var emailAddress: String
    var password: String
}


var isLoggedIn = false

class UserController {
    private var _credential: [User] = []
    
    static let shared = UserController()
    
    var credential: [User] {
        return _credential
    }
    
    func registerUser(user: User) {
        _credential.append(user)
        saveUsers()
    }
    
    init() {
        loadUsers()
    }
    
    private func saveUsers() {
        if let data = try? JSONEncoder().encode(_credential) {
            UserDefaults.standard.set(data, forKey: "users")
        }
    }
    
    private func loadUsers() {
        if let data = UserDefaults.standard.data(forKey: "users"),
           let users = try? JSONDecoder().decode([User].self, from: data) {
            _credential = users
        }
    }
}
