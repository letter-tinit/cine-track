import Foundation

// MARK: - Safe Decode Helper
extension KeyedDecodingContainer {
    func decodeSafe<T: Decodable>(_ type: T.Type, forKey key: Key) -> T? {
        return try? decodeIfPresent(type, forKey: key)
    }
}

// MARK: - MovieDetail
public struct MovieDetail: Decodable, Identifiable, Hashable {
    public let adult: Bool
    public let backdropPath: String?
    public let belongsToCollection: BelongsToCollection?
    public let budget: Int?
    public let genres: [Genre]
    public let homepage: String?
    public let id: Int
    public let imdbId: String?
    public let originCountry: [String]
    public let originalLanguage: String
    public let originalTitle: String
    public let overview: String?
    public let popularity: Double?
    public let posterPath: String?
    public let productionCompanies: [ProductionCompany]
    public let productionCountries: [ProductionCountry]
    public let releaseDate: String?
    public let revenue: Int?
    public let runtime: Int?
    public let spokenLanguages: [SpokenLanguage]
    public let status: String?
    public let tagline: String?
    public let title: String
    public let video: Bool
    public let voteAverage: Double?
    public let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget
        case genres
        case homepage
        case id
        case imdbId = "imdb_id"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // 🔴 Critical (fail if wrong)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        originalTitle = try container.decode(String.self, forKey: .originalTitle)
        video = try container.decode(Bool.self, forKey: .video)
        adult = try container.decode(Bool.self, forKey: .adult)

        // 🟡 Semi-critical (safe but with fallback)
        genres = container.decodeSafe([Genre].self, forKey: .genres) ?? []
        originCountry = container.decodeSafe([String].self, forKey: .originCountry) ?? []
        productionCompanies = container.decodeSafe([ProductionCompany].self, forKey: .productionCompanies) ?? []
        productionCountries = container.decodeSafe([ProductionCountry].self, forKey: .productionCountries) ?? []
        spokenLanguages = container.decodeSafe([SpokenLanguage].self, forKey: .spokenLanguages) ?? []

        // 🟢 Optional (safe decode)
        backdropPath = container.decodeSafe(String.self, forKey: .backdropPath)
        belongsToCollection = container.decodeSafe(BelongsToCollection.self, forKey: .belongsToCollection)
        budget = container.decodeSafe(Int.self, forKey: .budget)
        homepage = container.decodeSafe(String.self, forKey: .homepage)
        imdbId = container.decodeSafe(String.self, forKey: .imdbId)
        overview = container.decodeSafe(String.self, forKey: .overview)
        popularity = container.decodeSafe(Double.self, forKey: .popularity)
        posterPath = container.decodeSafe(String.self, forKey: .posterPath)
        releaseDate = container.decodeSafe(String.self, forKey: .releaseDate)
        revenue = container.decodeSafe(Int.self, forKey: .revenue)
        runtime = container.decodeSafe(Int.self, forKey: .runtime)
        status = container.decodeSafe(String.self, forKey: .status)
        tagline = container.decodeSafe(String.self, forKey: .tagline)
        voteAverage = container.decodeSafe(Double.self, forKey: .voteAverage)
        voteCount = container.decodeSafe(Int.self, forKey: .voteCount)
    }
    
    public init(
        adult: Bool,
        backdropPath: String?,
        belongsToCollection: BelongsToCollection?,
        budget: Int?,
        genres: [Genre],
        homepage: String?,
        id: Int,
        imdbId: String?,
        originCountry: [String],
        originalLanguage: String,
        originalTitle: String,
        overview: String?,
        popularity: Double?,
        posterPath: String?,
        productionCompanies: [ProductionCompany],
        productionCountries: [ProductionCountry],
        releaseDate: String?,
        revenue: Int?,
        runtime: Int?,
        spokenLanguages: [SpokenLanguage],
        status: String?,
        tagline: String?,
        title: String,
        video: Bool,
        voteAverage: Double?,
        voteCount: Int?
    ) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.belongsToCollection = belongsToCollection
        self.budget = budget
        self.genres = genres
        self.homepage = homepage
        self.id = id
        self.imdbId = imdbId
        self.originCountry = originCountry
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.productionCompanies = productionCompanies
        self.productionCountries = productionCountries
        self.releaseDate = releaseDate
        self.revenue = revenue
        self.runtime = runtime
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.tagline = tagline
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}

// MARK: - Sub Models

public struct Genre: Decodable, Hashable {
    let id: Int
    let name: String
}

public struct ProductionCompany: Decodable, Hashable {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - Helpers
extension ProductionCompany {
    var logoURL: URL? {
        guard let logoPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(logoPath)")
    }
}

public struct ProductionCountry: Decodable, Hashable {
    let iso31661: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name
    }
}

public struct SpokenLanguage: Decodable, Hashable {
    let englishName: String
    let iso6391: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
        case name
    }
}

public struct BelongsToCollection: Decodable, Hashable {
    let id: Int
    let name: String
    let posterPath: String?
    let backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

// MARK: - Helpers
extension MovieDetail {
    var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
    
    var backdropURL: URL? {
        guard let backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")
    }
    
    var ratingValue: Double {
        guard let voteAverage else { return 0.0 }
        return voteAverage / 2.0
    }
}

extension MovieDetail {
    static var mock: MovieDetail {
        .init(
            adult: false,
            backdropPath: "/1x9e0qWonw634NhIsRdvnneeqvN.jpg",
            belongsToCollection: nil,
            budget: 0,
            genres: [
                .init(id: 10749, name: "Romance"),
                .init(id: 18, name: "Drama")
            ],
            homepage: nil,
            id: 1523145,
            imdbId: "tt38190257",
            originCountry: ["RU"],
            originalLanguage: "ru",
            originalTitle: "Твоё сердце будет разбито",
            overview: "Having thwarted Bowser's previous plot to marry Princess Peach, Mario and Luigi now face a fresh threat in Bowser Jr., who is determined to liberate his father from captivity and restore the family legacy. Alongside companions new and old, the brothers travel across the stars to stop the young heir's crusade.",
            popularity: 821.6874,
            posterPath: "/7wIBfBl2gejt6xHxNSK0reVIm7E.jpg",
            productionCompanies: [],
            productionCountries: [],
            releaseDate: "2026-03-26",
            revenue: 0,
            runtime: 134,
            spokenLanguages: [],
            status: "Released",
            tagline: nil,
            title: "Your Heart Will Be Broken",
            video: false,
            voteAverage: 8.2,
            voteCount: 57
        )
    }
}
