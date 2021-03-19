//
//  DogApi.swift
//  DependencyDemo
//
//  Created by Peter Major on 18/03/2021.
//

import Foundation

protocol DogApi {
    func getImages(breed: String, completionHandler: @escaping (Result<DogImagesResponse, Error>) -> Void)
}

struct DogApiError: Error { }

class DogApiImpl: DogApi {

    private let session: URLSession
    private var dataTask: URLSessionDataTask?

    init(session: URLSession) {
        self.session = session
    }

    func getImages(breed: String, completionHandler: @escaping (Result<DogImagesResponse, Error>) -> Void) {
        dataTask?.cancel()

        guard let url = URL(string: "https://dog.ceo/api/breed/\(breed)/images") else {
            completionHandler(.failure(DogApiError()))
            return
        }

        dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            defer {
              self?.dataTask = nil
            }

            let sendResponse = { response in
                DispatchQueue.main.async { completionHandler(response) }
            }

            if let data = data,
               let response = response as? HTTPURLResponse,
               response.statusCode == 200 {

                do {
                    let content = try JSONDecoder().decode(DogImagesResponse.self, from: data)
                    sendResponse(.success(content))
                } catch {
                    sendResponse(.failure(error))
                }

            } else if let error = error {
                sendResponse(.failure(error))
            } else {
                sendResponse(.failure(DogApiError()))
            }
        }
        dataTask?.resume()
    }
}
