//
//  Service.swift
//  Clarity
//
//  Created by Nawaf Almutairi on 2/7/21.
//

import Foundation

struct Posts : Codable,Hashable,Identifiable {
    
    var id : Int
    var title : String
    var content : String
    var featured_image : String
//    var Date : String
//    var Language: String
}





class PostsModel: ObservableObject {

    @Published var post: [Posts]
    
    static let saveKey = "savedPosts"
    
    

    
    init() {
        if let data = UserDefaults.standard.data(forKey: PostsModel.saveKey) {
            if let decoded = try? JSONDecoder().decode([Posts].self, from: data) {
                self.post = decoded
                return
            }
        }

        self.post = []
    }

    
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(post) {
            UserDefaults.standard.set(encoded, forKey: PostsModel.saveKey)
        }
    }
    
    func fetchPostsJSON(completion: @escaping (Result<[Posts], Error>) -> ()) {

        let urlString = "https://claritymind.co/wp-json/api/v1/posts"

        guard let url = URL(string: urlString) else {return}

        URLSession.shared.dataTask(with: url) { (data, resp, err) in

            if let err = err {
                completion(.failure(err))
                return
            }

            // Worked

            do {
                let ps = try JSONDecoder().decode([Posts].self, from: data!)
                completion(.success(ps))
                self.post = ps
                print(self.post.count)
                
            }
            catch let jsonError{
                completion(.failure(jsonError))
            }

        }.resume()

    }
    
}



