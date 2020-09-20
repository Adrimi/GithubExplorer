//
//  SuggestionModel.swift
//  GithubExplorer
//
//  Created by adrian.szymanowski on 19/09/2020.
//

struct SuggestionModel: Codable {
    let id: Int
    let login: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
    }
}
