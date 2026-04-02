# 🎬 CineTrack

CineTrack is an iOS app built with **SwiftUI** that helps users explore trending movies using the TMDB API.

---

## 🚀 Features

* 🔥 Fetch Trending Movies
* 🖼 Display Movie Posters
* 🔍 Search Movies *(coming soon)*
* 🎯 Clean Architecture (Scalable for large projects)
* ⚡ Async/Await Networking
* 🔄 Combine (reactive updates)
* 💾 SwiftData (local storage – planned)

---

## 🧱 Architecture

This project follows **Clean Architecture**:

```
Presentation (SwiftUI)
    ↓
ViewModel
    ↓
UseCase (Business Logic)
    ↓
Repository (Abstraction)
    ↓
APIClient (Networking)
```

### Key Principles

* Separation of Concerns
* Dependency Injection
* Testable components
* Scalable for large projects

---

## 📡 API

* Source: The Movie Database (TMDB)
* Endpoint: `/trending/movie/day`

Example response:

```json
{
  "id": 1171145,
  "title": "Crime 101",
  "poster_path": "/tVvpFIoteRHNnoZMhdnwIVwJpCA.jpg"
}
```

---

## 🖼 Image Loading

Images are loaded using:

```
https://image.tmdb.org/t/p/w500/{poster_path}
```

Handled via `AsyncImage` in SwiftUI.

---

## 🛠 Tech Stack

* SwiftUI
* Async/Await
* Combine
* URLSession
* SwiftData *(planned)*

---

## 🧪 Preview & Mocking

The project uses **mock data** for SwiftUI previews:

* `Movie.mock`
* `MockMovieUseCase`

👉 This allows UI development without real API calls.

---

## ⚙️ Setup

1. Clone the repository
2. Add your TMDB API key

> ⚠️ Do NOT commit your API key

You can store it in:

* `.xcconfig`
* Environment variables

---

## 📌 Future Improvements

* Pagination
* Search & Filter
* Movie Detail Screen
* Favorites (Local storage)
* Unit Testing
* Image caching

---

## 👨‍💻 Author

* Built for learning SwiftUI + Clean Architecture
* Focus: scalable mobile app development

---

## 🧠 Mindset

> Build small → Make it clean → Scale later

---

## 📷 Preview

*(Add screenshots later)*

---

## ⭐️ Notes

This project is for learning purposes and will evolve over time.
