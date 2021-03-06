//
//  Articles.swift
//  HelloGKStateMachine
//
//  Created by JEROME on 2020/6/16.
//  Copyright © 2020 JEROME. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let articles = try? newJSONDecoder().decode(Articles.self, from: jsonData)

import Foundation

// MARK: - Articles
struct Articles: Codable {
  let status: String
  let totalResults: Int
  let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
  let source: Source
  let author, title, articleDescription: String?
  let url: String?
  let urlToImage: String?
  let publishedAt: String?
  let content: String?
  
  enum CodingKeys: String, CodingKey {
    case source, author, title
    case articleDescription = "description"
    case url, urlToImage, publishedAt, content
  }
}

// MARK: - Source
struct Source: Codable {
//  let id: JSONNull?
  let id: String?
  let name: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
  
  public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
    return true
  }
  
  public var hashValue: Int {
    return 0
  }
  
  public func hash(into hasher: inout Hasher) {
    // No-op
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
