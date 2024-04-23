import Foundation

protocol NetworkManagerProtocol {
    func fetchData<T: Decodable>(from url: String) async throws -> T
}

final class NetworkManager: NetworkManagerProtocol {
    func fetchData<T: Decodable>(from url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.httpError(0)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            switch httpResponse.statusCode {
            case 400:
                throw NetworkError.bodyInGet
            case 403:
                throw NetworkError.accessForbidden
            case 404:
                throw NetworkError.invalidURL
            case 500:
                throw NetworkError.invalidResponse(data, response)
            default:
                throw NetworkError.unknown
            }
        }
        
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch {
            throw NetworkError.httpError(0)
        }
    }
}
