//
//  repository.swift
//  repository
//
//  Created by @camapblue on 12/28/21.
//

public class Repository {
    public static let shared = Repository()
    
    private let baseUrl: BaseUrl
    init() {
        self.baseUrl = BaseUrl(apiEndpointUrl: RepositoryConfigs.shared.apiEndpointUrl)
    }
    
    // Repository
    public func contactRepository() -> ContactRepository {
        return ContactRepositoryImpl(
            contactDao: contactDao(), contactApi: contactApi()
        )
    }
    
    // Api
    func contactApi() -> ContactApi {
        return ContactApiImpl(baseUrl: baseUrl)
    }
    
    // Dao
    func contactDao() -> ContactDao {
        return ContactDaoImpl()
    }
}
