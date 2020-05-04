//
//  Posts.swift
//  DataManager
//
//  Created by GGsrvg on 03.05.2020.
//  Copyright © 2020 GGsrvg. All rights reserved.
//

import Foundation

// MARK: - Posts
public class Posts: Codable {
    public var data: PostsData
    public var errors: [ErrorRequest]?

    public init(data: PostsData, errors: [ErrorRequest]?) {
        self.data = data
        self.errors = errors
    }
}

// MARK: - PostsData
public class PostsData: Codable {
    public var items: [Item]
    public var cursor: String

    public init(items: [Item], cursor: String) {
        self.items = items
        self.cursor = cursor
    }
}

// MARK: - Item
public class Item: Codable {
    public var id: String
    public var replyOnPostID: JSONNull?
    public var type: ItemType
    public var thankedComment: JSONNull?
    public var status: Status
    public var hidingReason: JSONNull?
    public var coordinates: Coordinates?
    public var isCommentable, hasAdultContent, isAuthorHidden, isHidden: Bool
    public var contents: [Content]
    public var language: Language
    public var createdAt, updatedAt: Int
    public var page: JSONNull?
    public var author: Author?
    public var stats: Stats
    public var isMyFavorite: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case replyOnPostID = "replyOnPostId"
        case type, thankedComment, status, hidingReason, coordinates, isCommentable, hasAdultContent, isAuthorHidden, isHidden, contents, language, createdAt, updatedAt, page, author, stats, isMyFavorite
    }

    public init(id: String, replyOnPostID: JSONNull?, type: ItemType, thankedComment: JSONNull?, status: Status, hidingReason: JSONNull?, coordinates: Coordinates?, isCommentable: Bool, hasAdultContent: Bool, isAuthorHidden: Bool, isHidden: Bool, contents: [Content], language: Language, createdAt: Int, updatedAt: Int, page: JSONNull?, author: Author, stats: Stats, isMyFavorite: Bool) {
        self.id = id
        self.replyOnPostID = replyOnPostID
        self.type = type
        self.thankedComment = thankedComment
        self.status = status
        self.hidingReason = hidingReason
        self.coordinates = coordinates
        self.isCommentable = isCommentable
        self.hasAdultContent = hasAdultContent
        self.isAuthorHidden = isAuthorHidden
        self.isHidden = isHidden
        self.contents = contents
        self.language = language
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.page = page
        self.author = author
        self.stats = stats
        self.isMyFavorite = isMyFavorite
    }
}

// MARK: - Author
public class Author: Codable {
    public var id, name: String
    public var banner, photo: Banner?
    public var gender: Gender
    public var isHidden, isBlocked, isMessagingAllowed: Bool
    public var auth: Auth
    public var tagline: String
    public var data: AuthorData

    public init(id: String, name: String, banner: Banner?, photo: Banner?, gender: Gender, isHidden: Bool, isBlocked: Bool, isMessagingAllowed: Bool, auth: Auth, tagline: String, data: AuthorData) {
        self.id = id
        self.name = name
        self.banner = banner
        self.photo = photo
        self.gender = gender
        self.isHidden = isHidden
        self.isBlocked = isBlocked
        self.isMessagingAllowed = isMessagingAllowed
        self.auth = auth
        self.tagline = tagline
        self.data = data
    }
}

// MARK: - Auth
public class Auth: Codable {
    public var login: String
    public var rocketID: String?
    public var isDisabled: Bool
    public var level: Int

    enum CodingKeys: String, CodingKey {
        case login
        case rocketID = "rocketId"
        case isDisabled, level
    }

    public init(login: String, rocketID: String?, isDisabled: Bool, level: Int) {
        self.login = login
        self.rocketID = rocketID
        self.isDisabled = isDisabled
        self.level = level
    }
}

// MARK: - Banner
public class Banner: Codable {
    public var type: BannerType
    public var id: String
    public var data: BannerData

    public init(type: BannerType, id: String, data: BannerData) {
        self.type = type
        self.id = id
        self.data = data
    }
}

// MARK: - BannerData
public class BannerData: Codable {
    public var extraSmall: ExtraSmall
    public var small: ExtraSmall?
    public var original: ExtraSmall

    public init(extraSmall: ExtraSmall, small: ExtraSmall?, original: ExtraSmall) {
        self.extraSmall = extraSmall
        self.small = small
        self.original = original
    }
}

// MARK: - ExtraSmall
public class ExtraSmall: Codable {
    public var url: String
    public var size: Size

    public init(url: String, size: Size) {
        self.url = url
        self.size = size
    }
}

// MARK: - Size
public class Size: Codable {
    public var width, height: Int

    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
}

public enum BannerType: String, Codable {
    case image = "IMAGE"
    case tags = "TAGS"
    case text = "TEXT"
}

// MARK: - AuthorData
public class AuthorData: Codable {

    public init() {
    }
}

public enum Gender: String, Codable {
    case female = "FEMALE"
    case male = "MALE"
    case unset = "UNSET"
}

// MARK: - Content
public class Content: Codable {
    public var type: BannerType
    public var data: ContentData
    public var id: String?

    public init(type: BannerType, data: ContentData, id: String?) {
        self.type = type
        self.data = data
        self.id = id
    }
}

// MARK: - ContentData
public class ContentData: Codable {
    public var value: String?
    public var extraSmall, small: ExtraSmall?
    public var values: [String]?
    public var medium: ExtraSmall?

    public init(value: String?, extraSmall: ExtraSmall?, small: ExtraSmall?, values: [String]?, medium: ExtraSmall?) {
        self.value = value
        self.extraSmall = extraSmall
        self.small = small
        self.values = values
        self.medium = medium
    }
}

// MARK: - Coordinates
public class Coordinates: Codable {
    public var latitude, longitude: Double
    public var zoom: JSONNull?

    public init(latitude: Double, longitude: Double, zoom: JSONNull?) {
        self.latitude = latitude
        self.longitude = longitude
        self.zoom = zoom
    }
}

public enum Language: String, Codable {
    case en = "en"
}

// MARK: - Stats
public class Stats: Codable {
    public var likes, views, comments, shares: Comments
    public var replies, thanks, timeLeftToSpace: Comments

    public init(likes: Comments, views: Comments, comments: Comments, shares: Comments, replies: Comments, thanks: Comments, timeLeftToSpace: Comments) {
        self.likes = likes
        self.views = views
        self.comments = comments
        self.shares = shares
        self.replies = replies
        self.thanks = thanks
        self.timeLeftToSpace = timeLeftToSpace
    }
}

// MARK: - Comments
public class Comments: Codable {
    public var count: Int?
    public var my: Bool

    public init(count: Int?, my: Bool) {
        self.count = count
        self.my = my
    }
}

public enum Status: String, Codable {
    case published = "PUBLISHED"
}

public enum ItemType: String, Codable {
    case plain = "PLAIN"
    case plainCover = "PLAIN_COVER"
}

// MARK: - ErrorRequest
public class ErrorRequest: Codable {
    public var querystringAfter: String

    enum CodingKeys: String, CodingKey {
        case querystringAfter = ".querystring.after"
    }

    public init(querystringAfter: String) {
        self.querystringAfter = querystringAfter
    }
}

// MARK: - Encode/decode helpers
public class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
