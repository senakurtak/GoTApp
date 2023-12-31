import Foundation

protocol NetworkManagerProtocol {
    associatedtype ResultType
    
    func fetchData<T: Decodable>(from url: String, completion: @escaping (Result<T, NetworkError>) -> Void) -> URLSessionTask
}

final class NetworkManager<ResultType>: NetworkManagerProtocol {
    func fetchData<T: Decodable>(from url: String, completion: @escaping (Result<T, NetworkError>) -> Void) -> URLSessionTask {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return URLSessionTask()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(.noInternet))
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.httpError(.bitWidth)))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                switch response.statusCode {
                case 400:
                    completion(.failure(.bodyInGet))
                case 403:
                    completion(.failure(.accessForbidden))
                case 404:
                    completion(.failure(.invalidURL))
                case 500:
                    completion(.failure(.invalidResponse(data, response)))
                default:
                    completion(.failure(.unknown))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.httpError(.bitWidth)))
            }
        }
        task.resume()
        return task
    }
}
