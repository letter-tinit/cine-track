//
//  FavoriteMapper.swift
//  CineTrack
//
//  Created by TiniT on 21/4/26.
//

struct FavoriteMapper {
    static func toEntity(from movie: Movie) -> FavoriteMovieEntity {
        .init(
            id: movie.id,
            title: movie.title,
            originalTitle: movie.originalTitle,
            overview: movie.overview,
            posterPath: movie.posterPath,
            backdropPath: movie.backdropPath,
            genreIDs: movie.genreIDs,
            popularity: movie.popularity,
            releaseDate: movie.releaseDate,
            voteAverage: movie.voteAverage,
            voteCount: movie.voteCount,
            adult:movie.adult,
            video: movie.video
        )
    }
    
    static func toDomain(from movie: FavoriteMovieEntity) -> Movie {
        .init(
            id: movie.id,
            title: movie.title,
            originalTitle: movie.originalTitle,
            overview: movie.overview,
            posterPath: movie.posterPath,
            backdropPath: movie.backdropPath,
            genreIDs: movie.genreIDs,
            popularity: movie.popularity,
            releaseDate: movie.releaseDate,
            voteAverage: movie.voteAverage,
            voteCount: movie.voteCount,
            adult:movie.adult,
            video: movie.video
        )
    }
}
