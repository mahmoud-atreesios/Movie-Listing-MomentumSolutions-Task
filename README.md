Movie-Listing-MomentumSolutions-Task
This project is a movie listing application developed as part of a task for Momentum Solutions. It demonstrates the ability to consume and display data from a remote API, applying clean architecture principles and modern iOS development practices.

---

## 📲 Features

- ✅ Fetches popular movies from TMDB API
- ✅ Displays movies in a UICollectionView
- ✅ Supports toggling favorite status for each movie
- ✅ Persists favorite movies using UserDefaults
- ✅ Caches movies to handle offline scenarios
- ✅ Follows MVVM architecture with use cases
- ✅ Uses Combine for reactive bindings

---

## Screenshots
### Movie List Screen, Movie Details Screen
<p align="center">
  <img src="https://github.com/user-attachments/assets/7a6c0555-2df6-4f3d-9eb0-cbf1d9ceaa76" alt="Movie List" width="40%" />
  <img src="https://github.com/user-attachments/assets/bfe074d0-68f7-432f-8c9c-6a6ba7313213" alt="Movie Details" width="40%" />
</p>

---

## 🛠 Technologies Used

- ✅ Swift
- ✅ UIKit
- ✅ Combine
- ✅ MVVM architecture
- ✅ URLSession (networking)
- ✅ UserDefaults (for storing favorites)
- ✅ Protocol-Oriented Programming
- ✅ XCTest (unit testing)

---

## 🚀 Getting Started

- ✅ Clone the repository
- ✅ open MovieListingApp.xcodeproj

---

## 🧪 Testing

- ✅ Unit tested `MovieListViewModel` fetch success case  
- ✅ Verified that fetched movies are published correctly  

---

## 📈 Improvements Planned

### 🔄 Add unit tests for:
- Use cases  
- Cache service  
- Favorite service  
- Networking layer  

### 🔄 Add support for:
- Pagination  
- Search functionality
- Localization 

## 🧠 Challenges Faced

- Designing a flexible yet simple architecture for a small-scale app  
- Handling offline mode and favorite persistence without Core Data  
- Managing Combine publishers and memory effectively  
- Maintaining a clean separation of concerns using protocol-based abstractions  

---

## 👨‍🔬 Notes for Reviewers

- 🧪 Only `MovieListViewModel` is currently unit tested for a successful fetch  
- 🛠 I plan to cover the use cases and networking layer with unit tests next  
- 🧠 Focused on building a scalable and testable architecture from the start 
