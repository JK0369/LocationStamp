//
//  ReverseGeoCodingTarget.swift
//  Domain
//
//  Created by 김종권 on 2020/12/31.
//

import Foundation
import Moya

public enum ReverseGeoCodingTarget {
    case reverseGeoCoding(ReverseGeoCodingRequest)
}

extension ReverseGeoCodingTarget: BaseTargetType {

    public var baseURL: URL {
        return URL(string: "https://api.bigdatacloud.net/")!
    }

    public var path: String {
        switch self {
        case .reverseGeoCoding:
            return "data/reverse-geocode-client"
        }
    }

    public var method: Moya.Method {
        return .get
    }

    public var sampleData: Data {
        switch self {
        case .reverseGeoCoding:
            return """
                {
                  "latitude": 37.325130462646484,
                  "longitude": 127.1183853149414,
                  "plusCode": "8Q9984G9+39",
                  "localityLanguageRequested": "ko",
                  "continent": "아시아",
                  "continentCode": "AS",
                  "countryName": "남조선",
                  "countryCode": "KR",
                  "principalSubdivision": "경기도",
                  "principalSubdivisionCode": "KR-41",
                  "city": "용인시",
                  "locality": "수지구",
                  "postcode": "",
                  "localityInfo": {
                    "administrative": [
                      {
                        "order": 3,
                        "adminLevel": 2,
                        "name": "남조선",
                        "description": "동북아시아의 나라.",
                        "isoName": "Korea (the Republic of)",
                        "isoCode": "KR",
                        "wikidataId": "Q884",
                        "geonameId": 1835841
                      },
                      {
                        "order": 4,
                        "adminLevel": 4,
                        "name": "경기도",
                        "description": "대한민국의 도",
                        "isoName": "Gyeonggi-do",
                        "isoCode": "KR-41",
                        "wikidataId": "Q20937",
                        "geonameId": 1841610
                      },
                      {
                        "order": 5,
                        "adminLevel": 6,
                        "name": "용인시",
                        "description": "대한민국 경기도의 시",
                        "wikidataId": "Q18459",
                        "geonameId": 1832426
                      },
                      {
                        "order": 6,
                        "adminLevel": 7,
                        "name": "수지구"
                      }
                    ],
                    "informative": [
                      {
                        "order": 1,
                        "name": "아시아",
                        "description": "지구에서 가장 넓고, 인구가 많은 대륙",
                        "isoCode": "AS",
                        "wikidataId": "Q48",
                        "geonameId": 6255147
                      },
                      {
                        "order": 2,
                        "name": "한반도",
                        "description": "동아시아의 반도",
                        "wikidataId": "Q483134"
                      }
                    ]
                  }
                }
                """.data(using: .utf8)!
        }
    }

    public var task: Task {
        switch self {
        case .reverseGeoCoding(let request):
            return .requestParameters(parameters: request.toDictionary(), encoding: URLEncoding.queryString)
        }
    }
}
