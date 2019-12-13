//  Created by Faridho Luedfi on 07/12/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

extension URL {
    static var appBaseURL: URL {
        //guard let baseURLString = Bundle.main.object(forInfoDictionaryKey: "AntridocNetworkBaseURL") as? String else { fatalError("Newtwork: Base URL String not configured in info.plist") }
        let baseURLString = "http://127.0.0.1:8000/api/v1"
        guard let url = URL(string: baseURLString) else { fatalError("Base URL not configured") }
        return url
    }
}
