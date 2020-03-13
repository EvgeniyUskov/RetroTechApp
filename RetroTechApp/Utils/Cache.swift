import Foundation

class Cache {

    let cache: NSCache<NSString, ComputerDetailsViewModel>
    
    static var cacheInstance: Cache = {
        let instance = Cache()
        return instance
    }()
    
    private init() {
        cache = NSCache<NSString, ComputerDetailsViewModel>()
    }
}
