//
//  ClarityModel.swift
//  Clarity
//
//  Created by Nawaf Almutairi on 2/7/21.
//

import Foundation
import UIKit

class ClarityModel: NSObject {
    
//    
//    func getData(completion: @escaping ([Posts]) -> ()) {
//
//        let urlString = "https://claritymind.co/service.php"
//        guard let url = URL(string: urlString) else {return}
//
//        URLSession.shared.dataTask(with: url) { (data, _, error) in
//            do {
//            let post = try JSONDecoder().decode([Posts].self,from:data!)
//
//            print(post)
//            DispatchQueue.main.async {
//                completion(post)
//            }
//            }
//            catch {
//                print("OPSY",error)
//            }
//
//
//
//        }.resume()
//
//    }
    
    func fetchPostsJSON(completion: @escaping (Result<[Posts], Error>) -> ()) {

        let urlString = "https://claritymind.co/service.php"

        guard let url = URL(string: urlString) else {return}

        URLSession.shared.dataTask(with: url) { (data, resp, err) in

            if let err = err {
                completion(.failure(err))
                return
            }


            // Worked

            do {
                let post = try JSONDecoder().decode([Posts].self, from: data!)
                completion(.success(post))

            }
            catch let jsonError{
                completion(.failure(jsonError))
            }

        }.resume()

    }
    
    
}
