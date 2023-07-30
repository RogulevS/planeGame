import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    init() {
    }
    
    func saveResults(results: GameResults) {
        var savedResults = receiveResults()
        savedResults?.append(results)
        
        UserDefaults.standard.setValue(encodable: savedResults, forKey: Resources.UserDefaultsKeys.resultKey)
    }
    
    func receiveResults() -> [GameResults]? {
        guard let models = UserDefaults.standard.loadValue([GameResults].self, forKey: Resources.UserDefaultsKeys.resultKey) else { return [] }
        return models
    }
}

extension UserDefaults {
    func setValue<T: Encodable>(encodable: T, forKey key: String) {
        guard let data = try? JSONEncoder().encode(encodable) else { return }
        set(data, forKey: key)
    }
    
    func loadValue<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = object(forKey: key) as? Data,
              let value = try? JSONDecoder().decode(type, from: data) else { return nil }
        return value
    }
}
